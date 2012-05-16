class AddIsErbToDesign < ActiveRecord::Migration
  def self.up
    add_column :designs, :is_erb, :boolean
  end

  def self.down
    remove_column :designs, :is_erb
  end
end
