class EventsController < InheritedResources::Base
  before_filter :authenticate_admin_user, :except => :postback
  def postback
    p params
    event = Event.new
    event.event = params[:event]
    event.email = params[:email]
    event.category = params[:category]
    event.content = params
    event.save!
    render :nothing => true
  end
end
