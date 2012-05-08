# -*- encoding : utf-8 -*-
class AddContentToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :content, :text
  end

  def self.down
    remove_column :events, :content
  end
end
