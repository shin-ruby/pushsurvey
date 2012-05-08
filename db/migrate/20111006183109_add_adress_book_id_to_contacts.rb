# -*- encoding : utf-8 -*-
class AddAdressBookIdToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :address_book_id, :integer
  end

  def self.down
    remove_column :contacts, :address_book_id
  end
end
