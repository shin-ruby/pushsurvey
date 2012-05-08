# -*- encoding : utf-8 -*-
class AddUserIdToPush < ActiveRecord::Migration
  def self.up
    add_column :pushes, :user_id, :integer
  end

  def self.down
    remove_column :pushes, :user_id
  end
end
