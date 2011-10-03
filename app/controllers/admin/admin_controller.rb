class Admin::AdminController < ApplicationController
  layout "admin"
  def index
  end

  private
  def admin_required
    unless current_user &&  current_user.admin?
      redirect_to "/"
    end
  end
end
