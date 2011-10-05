class ApplicationController < ActionController::Base
  protect_from_forgery

  #alias original_authenticate_user! authenticate_user!
  #def authenticate_user!
  #  original_authenticate_user!
  #  Thread.current[:user_id] = (current_user.id rescue nil)
  #
  #end
  before_filter :authenticate_user!
  before_filter :set_user
  private
    def set_user
      Thread.current[:user_id] = (current_user.id rescue nil)
    end


  def authenticate_admin_user
    unless current_user &&  current_user.admin?
      redirect_to "/", :notice => "You don't have permission to operate admin section "
      #return false
    end
  end
end
