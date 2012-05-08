# -*- encoding : utf-8 -*-
class CreateDesigns < ActiveRecord::Migration
  def self.up
    create_table :designs do |t|
      t.string :name
      t.text :html

      t.timestamps
    end
  end

  def self.down
    drop_table :designs
  end
end
