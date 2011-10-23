class AddUrlToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :url, :string

    add_index :contacts, [:address_book_id, :email]#, :unique => true
  end

  def self.down
    remove_column :events, :url

    remove_index :contacts, [:address_book_id, :email]
  end
end
