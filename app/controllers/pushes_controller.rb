class PushesController < InheritedResources::Base
  load_and_authorize_resource

  #act_wizardly_for :user
  def index
    @pushes = Push.with_user
  end

  #export
  def save

  end
end
