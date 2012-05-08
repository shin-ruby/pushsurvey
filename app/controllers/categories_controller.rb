# -*- encoding : utf-8 -*-
class CategoriesController < InheritedResources::Base
  before_filter :authenticate_admin_user
end
