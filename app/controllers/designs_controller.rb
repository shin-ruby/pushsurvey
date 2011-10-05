class DesignsController < InheritedResources::Base
  def index
    @designs = Design.with_user
  end
end
