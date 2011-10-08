class PushesController < InheritedResources::Base
  load_and_authorize_resource

  #act_wizardly_for :user
end
