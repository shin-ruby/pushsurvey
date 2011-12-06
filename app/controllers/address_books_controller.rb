require 'csv'
require 'csv_importer'
class AddressBooksController < InheritedResources::Base
  load_and_authorize_resource :except => [:export, :import]

  def index
    @address_books = AddressBook.with_user.active

  end

  def new
    @address_book = current_address_book
    if @address_book && params[:type] == "new"
      @address_book.destroy
      @address_book = nil
    end
    @address_book ||= AddressBook.new
    @address_book.instance_variable_set("@new_record", true)
  end


  def create


    @address_book = current_address_book
    @address_book ||= AddressBook.new
    @address_book.update_attributes(params[:address_book])


    if @address_book.save
      @address_book.next_step
      @address_book.disable_validation = true
      @address_book.save!

      if @address_book.step.nil? #last_step
        redirect_to import_address_book_path(@address_book)
        return
      end
    end


    @address_book.instance_variable_set("@new_record", true)
    render "new"


  end

  def export
    @address_book = AddressBook.find(params[:id])
    authorize! :read, @address_book

    result = [["email", "firstname", "lastname", "name"]]
    @address_book.contacts.each do |contact|
      result << [contact.email, contact.firstname, contact.lastname, contact.name]
    end


    buf = ''
    result.each do |row|
      parsed_cells = CSV.generate_row(row, 4, buf)
      puts "Created #{ parsed_cells } cells."
    end
    p buf


    send_data buf, :type => "text/csv", :filename => "#{@address_book.name}.csv", :disposition => "inline"

  end

  def import
    @address_book = AddressBook.find(params[:id])
    @contacts_value = "=\n"
    if request.get?

    elsif request.put? || request.post?
      if params[:add_contact]
        if params[:contacts].present? && params[:contacts].strip != "="
        #InlineCsvImporter.new(params[:contacts],@address_book).import
          CsvImporter.new(@address_book, :string => params[:contacts]).delay.import
        else
          flash[:notice] = "Please input information for importing contacts"
         redirect_to :action=>"import"
          return
        end
      elsif params[:upload]
        if params[:file]
          ext = params[:file].original_filename[params[:file].original_filename.rindex(".")+1..-1]
          if ext.downcase != "csv"
            flash[:notice] = "Please upload csv file for importing contacts"
            redirect_to :action=>"import"
            return
          end
          Object.const_get((ext.capitalize + "Importer")).new(@address_book, :file=>params[:file].tempfile.instance_variable_get("@tmpname")).delay.import
        else
           flash[:notice] = "Please input file for uploading contacts"
           redirect_to :action=>"import"
           return
        end
        #Delayed::Job.enqueue Object.const_get((ext.capitalize + "Importer")).new(params[:file].tempfile.instance_variable_get("@tmpname"), @address_book)

      end
      redirect_to :controller=>"confirmation", :action=>"confirmation",:from=>"address_book"
    end
  end

  def show_data
    result = {}
    result["sEcho"] = params["sEcho"]

    @address_book = AddressBook.find(params[:id])
    #result["iTotalRecords"] = address_book.contacts_count
    #result["iTotalDisplayRecords"] = address_book.contacts_count
    #result["aaData"] = []
    ##address_book.contacts.limit(100).offset(2).each do |contact|
    #result["aaData"] << ["", "" ,contact.email,contact.firstname,contact.lastname,contact.name]
    #end
    #puts result.to_json
    #respond_to do |format|
    #format.json {render :json => result.to_json}

    puts "done"
    render(:json =>
               for_data_table(self, %w[email firstname] + %w(email firstname lastname name)) do |contact|
                 ["<%= link_to image_tag(\"delete.png\"), object, :confirm => 'Are you sure?', :method => :delete %>",
                  "<%= link_to image_tag(\"modify.png\"), edit_contact_path(object) %>", contact.email, contact.firstname, contact.lastname, contact.name]
               end)
    #end

  end

  private
  #current unfinished push or nil
  def current_address_book
    AddressBook.where("step is not null").where(:user_id => current_user.id).all[0]
  end

  def for_data_table controller, fields, search_fields=nil, explicit_block=nil, &implicit_block
    params = Hash[*controller.params.map { |key, value| [key.to_s.downcase.to_sym, value] }.flatten]
    search_fields ||= fields
    block = (explicit_block or implicit_block)
    contacts_count = @address_book.contacts_count
    objects = _find_objects params, fields, search_fields


    matching_count = objects.respond_to?(:total_entries) ? objects.total_entries : _matching_count(params, search_fields)

    {:sEcho => params[:secho].to_i,
     :iTotalRecords => contacts_count,
     :iTotalDisplayRecords => matching_count,
     :aaData => _yield_and_render_array(controller, objects, block)
    }.to_json.html_safe
  end

  def _find_objects params, fields, search_fields
    @address_book.contacts.where(_where_conditions params[:ssearch], search_fields).
        includes(_discover_joins fields).
        order(_order_fields params, fields).
        page(_page(params)).per(_per_page(params))
  end

  def _matching_count params, search_fields
    @address_book.contacts.where(_where_conditions params[:ssearch], search_fields).count
  end

  def _discover_joins fields
    joins = Set.new
    object = Contact.new

    fields.each { |it|
      field = it.split('.')

      if (field.size == 2) then
        if object.respond_to?(field[0].to_sym)
          joins.add field[0].to_sym
        elsif object.respond_to?(field[0].singularize.to_sym)
          joins.add field[0].singularize.to_sym
        end
      end
    }

    joins.to_a
  end

  def _where_conditions query, search_fields, join_operator = "OR"
    return if query.blank?

    all_conditions = []
    all_parameters = []

    query.split.each do |term|
      conditions = []
      parameters = []

      search_fields.each do |field|
        next if (clause = _where_condition(term, field.dup)).empty?
        conditions << clause.shift
        parameters += clause
      end

      all_conditions << conditions
      all_parameters << parameters
    end

    [all_conditions.map { |conditions| "(" + conditions.join(" #{join_operator} ") + ")" }.join(" AND "), *all_parameters.flatten]
  end

  def _where_condition query, field
    return [] if query.blank?

    if field.is_a? Array
      options = field.extract_options!

      if options[:split]
        _split_where_condition query, field, options[:split]
      elsif options[:date]
        _date_where_condition query, field.first
      else
        _where_conditions(query, field, "AND")
      end
    else
      ["UPPER(#{field}) LIKE ?", "%#{query.upcase}%"]
    end
  end

  def _date_where_condition query, field
    begin
      ["#{field} = ?", Date.parse(query)]
    rescue ArgumentError
      []
    end
  end

  def _split_where_condition query, fields, splitter
    conditions = []
    parameters = []
    split_query = query.split splitter

    if split_query.size == fields.size
      fields.map do |f|
        conditions << "UPPER(#{f}) LIKE ?"
        parameters << "%#{split_query.shift.upcase}%"
      end

      ["(" + conditions.join(" AND ") + ")", *parameters]
    else
      []
    end
  end

  def _order_fields params, fields
    direction = params[:ssortdir_0] == "asc" ? "ASC" : "DESC"
    %{#{fields[params[:isortcol_0].to_i]} #{direction}}
  end

  private

  def _yield_and_render_array controller, objects, block
    objects.map do |object|
      block[object].map do |string|
        controller.instance_eval %{
            Rails.logger.silence do
              render_to_string :inline => %Q|#{string}|, :locals => {:object => object}
            end
          }
      end
    end
  end

  def _page params
    params[:idisplaystart].to_i / params[:idisplaylength].to_i + 1
  end

  def _per_page params
    case (display_length = params[:idisplaylength].to_i)
      when -1 then
        self.count
      when 0 then
        25
      else
        display_length
    end
  end

end
