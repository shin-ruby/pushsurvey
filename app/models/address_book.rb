class AddressBook < ActiveRecord::Base
  has_many :contacts
end
