# -*- encoding : utf-8 -*-
class AddColumnsToContacts < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :industry
    add_column :contacts, :level1_industry, :string
    add_column :contacts, :level2_industry, :string
    add_column :contacts, :pc_number, :string
  end

  def self.down
    add_column :contacts, :industry, :string
    remove_column :contacts, :pc_number
    remove_column :contacts, :level2_industry
    remove_column :contacts, :level1_industry
  end
end
