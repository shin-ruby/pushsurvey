# -*- encoding : utf-8 -*-
class CreatePushes < ActiveRecord::Migration
  def self.up
    create_table :pushes do |t|
      t.string :name
      t.date :date_push
      t.integer :design_id
      t.float :feedback
      t.string :status, :default => "Draft"
      t.integer :folder_id
      t.integer :category_id
      t.text :comment
      t.integer :address_book_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pushes
  end
end
