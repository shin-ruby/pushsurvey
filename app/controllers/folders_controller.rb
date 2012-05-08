# -*- encoding : utf-8 -*-
class FoldersController < InheritedResources::Base
  before_filter :authenticate_admin_user
end
