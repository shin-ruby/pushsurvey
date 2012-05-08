# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  #alias original_authenticate_user! authenticate_user!
  #def authenticate_user!
  #  original_authenticate_user!
  #  Thread.current[:user_id] = (current_user.id rescue nil)
  #
  #end
  before_filter :authenticate_user!,:set_user


  rescue_from CanCan::AccessDenied do |exception|
    begin
      redirect_to collection_url, :alert => exception.message
    rescue
      #no collection_url? redirect to root_url
      redirect_to root_url, :alert => exception.message
    end
  end

  private
    def set_user

      if current_user
       Thread.current[:user_id] = current_user.id
      else
        Thread.current[:user_id] = nil
      end
    end


  def authenticate_admin_user
    unless current_user &&  current_user.admin?
      redirect_to "/", :notice => "You don't have permission to operate admin section "
      #return false
    end
  end


end
