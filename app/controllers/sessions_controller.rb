class SessionsController < Devise::SessionsController
  layout nil, :only => :new

end