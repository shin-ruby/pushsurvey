require 'csv'
class AddressBooksController < InheritedResources::Base
  load_and_authorize_resource :except => [:export,:import]

  def index
    @address_books = AddressBook.with_user.active

  end

  def new
    @address_book = current_address_book
    @address_book ||= AddressBook.new
    if params[:type] == "new"
      @address_book.destroy
      @address_book = AddressBook.new
    end

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
        redirect_to @address_book
        return
      end
    end

    if params[:to_import]
      render "import"
    else
      @address_book.instance_variable_set("@new_record", true)
      render "new"
    end

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
    @address_book =   AddressBook.find(params[:id])
    @contacts_value = ""
    if request.get?

    elsif request.put? || request.post?
      if params[:add_contact]
        InlineCsvImporter.new(params[:contacts],@address_book).import
      elsif params[:upload]
         Importer.do_import(params[:file],@address_book)
      end

      redirect_to import_address_book_path(@address_book)
    end
  end

  private
  #current unfinished push or nil
  def current_address_book
    AddressBook.where("step is not null").where(:user_id => current_user.id).all[0]
  end
end
