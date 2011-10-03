class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  def authenticate_admin_user
    unless current_user &&  current_user.admin?
      redirect_to "/", :notice => "You don't have permission to operate admin section "
      #return false
    end
  end
end
