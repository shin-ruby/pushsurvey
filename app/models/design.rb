class Design < ActiveRecord::Base
  acts_as_audited
  include UserResource
  validates_presence_of :name
end
