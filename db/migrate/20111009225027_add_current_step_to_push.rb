class AddCurrentStepToPush < ActiveRecord::Migration
  def self.up
    add_column :pushes, :step, :string, :default => "name"
  end

  def self.down
    remove_column :pushes, :step
  end
end
