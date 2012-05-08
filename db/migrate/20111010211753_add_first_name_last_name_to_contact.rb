# -*- encoding : utf-8 -*-
class AddFirstNameLastNameToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :firstname, :string
    add_column :contacts, :lastname, :string
  end

  def self.down
    remove_column :contacts, :lastname
    remove_column :contacts, :firstname
  end
end
