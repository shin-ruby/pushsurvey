class PushesController < InheritedResources::Base
  load_and_authorize_resource :except => [:new,:create]

  #act_wizardly_for :user
  def index
    @pushes = Push.with_user.active

  end

  def new
    @push = current_push
    @push ||= Push.new
    if params[:type] == "new"
       @push.destroy
       @push = Push.new
    end

    @push.instance_variable_set("@new_record",true)
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
    @push.instance_variable_set("@new_record",true)
    render "new"
  end

  #export
  def export
     @push = Push.find(params[:id])
     authorize! :read, @push
  end

  def start
    @push = Push.find(params[:id])
     authorize! :start, @push

    @push.start
    redirect_to pushes_path, :notice => "Push successfully sent"

  end

  private
    #current unfinished push or nil
    def current_push
     Push.where("step is not null").where(:user_id => current_user.id).all[0]
    end
end
