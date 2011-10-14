class EventsController < InheritedResources::Base
  before_filter :authenticate_admin_user, :except => :postback
  def postback
    #p params
    event = Event.new(params)
    event.save!
  end
end
