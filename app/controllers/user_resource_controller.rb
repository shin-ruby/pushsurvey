# -*- encoding : utf-8 -*-
class UserResourceController < InheritedResources::Base
  protected
  def collection
      end_of_association_chain.with_user
  end


end
