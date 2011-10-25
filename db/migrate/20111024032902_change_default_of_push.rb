class ChangeDefaultOfPush < ActiveRecord::Migration
  def self.up

    change_column_default(:pushes, :status, nil)
  end

  def self.down
    change_column_default(:pushes, :status, 'Draft')
  end
end
