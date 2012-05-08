# -*- encoding : utf-8 -*-
class AddUserIdToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :user_id, :integer
  end

  def self.down
    remove_column :designs, :user_id
  end
end
