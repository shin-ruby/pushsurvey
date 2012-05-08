# -*- encoding : utf-8 -*-
class AddCompanyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :company, :string
    add_column :users, :name, :string
    add_column :users, :department, :string
    add_column :users, :position, :string
    add_column :users, :group_id, :integer
  end

  def self.down
    remove_column :users, :group_id
    remove_column :users, :position
    remove_column :users, :department
    remove_column :users, :name
    remove_column :users, :company
  end
end
