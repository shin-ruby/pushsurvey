class AddContactsCountToAddressBook < ActiveRecord::Migration
  def self.up
    add_column :address_books, :contacts_count, :integer
  end

  def self.down
    remove_column :address_books, :contacts_count
  end
end
