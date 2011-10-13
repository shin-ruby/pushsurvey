class Design < ActiveRecord::Base
  acts_as_audited
  include UserResource
end
