# -*- encoding : utf-8 -*-
class AddUserIdToAddressBook < ActiveRecord::Migration
  def self.up
    add_column :address_books, :user_id, :integer
  end

  def self.down
    remove_column :address_books, :user_id
  end
end
