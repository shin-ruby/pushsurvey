class EventsController < InheritedResources::Base
  skip_before_filter :authenticate_user!
  before_filter :authenticate_admin_user, :except => :postback
  def postback
    logger.info "event param:"
    logger.info params.inspect
    event = Event.new
    event.event = params[:event]
    event.email = params[:email]
    event.category = params[:category]
    event.url = params[:url].strip if params[:url].present?
    event.content = params
    event.save!
    render :nothing => true
  end
end
