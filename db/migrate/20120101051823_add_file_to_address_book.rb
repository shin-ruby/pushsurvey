# -*- encoding : utf-8 -*-
class AddFileToAddressBook < ActiveRecord::Migration
  def self.up
    add_column :address_books, :file, :string
  end

  def self.down
    remove_column :address_books, :file
  end
end
