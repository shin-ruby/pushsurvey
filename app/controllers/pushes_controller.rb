require 'csv'
class PushesController < InheritedResources::Base
  load_and_authorize_resource :except => [:new, :create, :export]

  #act_wizardly_for :user
  def index
    @pushes = Push.with_user.active

  end

  def new
    @push = current_push
    if @push && params[:type] == "new"
      @push.destroy
      @push = nil
    end

    @push ||= Push.new

    @push.instance_variable_set("@new_record", true)
  end


  def create

    if params[:new_type]
      if params[:new_type] == "new"
        @push = Push.new(params[:push])
      elsif params[:new_type] == "copy"
        @push = Push.new()
        @push.name = params[:copy_push_name]
        copy_push = Push.find(params[:copy_push_id])

        @push.category_id = copy_push.category_id
        @push.folder_id = copy_push.folder_id
        @push.address_book_id = copy_push.address_book_id
        @push.design_id = copy_push.design_id

        @push.subject = copy_push.subject
        @push.signature = copy_push.signature
        @push.from_email = copy_push.from_email
        @push.reply_to_email = copy_push.reply_to_email
      else
        raise "unknown create push type"
      end
    else
      @push = current_push
      @push.update_attributes(params[:push])
    end


    if @push.save
      @push.next_step
      @push.disable_validation = true
      @push.save!

      if @push.step.nil? #last_step
        redirect_to @push
        return
      end
    end
    @push.instance_variable_set("@new_record", true)
    render "new"
  end

  #export
  def export
    @push = Push.find(params[:id])
    authorize! :read, @push

    if params[:type]
      @contacts = Event.where(:event => params[:type]).where(:category => "push-#{params[:id]}")
    else #all push contacts
      #@contacts = @push.contacts
       t = Table("public/foo.csv")
       grouping = Grouping(t,:by => "name")
       time = Time.now
       data = grouping.to_pdf
       puts "timing : #{Time.now - time}"
      #data = Push.with_user.active.report_table.to_csv
      #p data
       #send_data data, :type => "application/csv", :filename => "#{params[:type]} list for #{@push.name}.csv", :disposition => "inline"
       time = Time.now


      send_data data, :type => "application/pdf", :filename => "#{params[:type]} list for #{@push.name}.pdf", :disposition => "inline"
       puts "timing2 : #{Time.now - time}"
        return
    end

    result = [["email"]]
    @contacts.each do |contact|
      result << [contact.email]
    end


    buf = ''
    result.each do |row|
      parsed_cells = CSV.generate_row(row, 1, buf)
      puts "Created #{ parsed_cells } cells."
    end
    p buf

    send_data buf, :type => "text/csv", :filename => "#{params[:type]} list for #{@push.name}.csv", :disposition => "inline"


  end

  def start
    if double_submit?
      redirect_to collection_path, :notice => "Please do not submit the form twice."
      return
    end
    @push = Push.find(params[:id])
    authorize! :start, @push

    Delayed::Job.enqueue @push
    redirect_to :controller=>"confirmation", :action=>"confirmation",:from=>"push" #, :notice => "Your request has been successfully submitted, Please wait until we email you the result."
    #Object.new.send(:exit)

  end

  private
  #current unfinished push or nil
  def current_push
    Push.where("step is not null").where(:user_id => current_user.id).all[0]
  end
end
