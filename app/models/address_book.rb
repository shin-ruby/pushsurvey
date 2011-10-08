class AddressBook < ActiveRecord::Base
  include UserResource

  has_many :contacts

  validates_presence_of :name
end
