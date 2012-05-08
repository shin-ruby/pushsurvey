# -*- encoding : utf-8 -*-
class SessionsController < Devise::SessionsController
  layout nil, :only => :new
   def create
    super
    Thread.current[:user_id] = current_user.id if current_user
  end

  def destroy
    super
    Thread.current[:user_id] = nil if !current_user
  end
end
