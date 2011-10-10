class AddressBooksController < InheritedResources::Base
  load_and_authorize_resource

  def new
    @address_book = current_address_book
    @address_book ||= AddressBook.new
    if params[:type] == "new"
       @address_book.destroy
       @address_book = AddressBook.new
    end

    @address_book.instance_variable_set("@new_record",true)
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
    @address_book.instance_variable_set("@new_record",true)
    render "new"
  end

  def export

  end

  def add_once

  end

  private
    #current unfinished push or nil
    def current_address_book
     AddressBook.where("step is not null").where(:user_id => current_user.id).all[0]
    end
end
