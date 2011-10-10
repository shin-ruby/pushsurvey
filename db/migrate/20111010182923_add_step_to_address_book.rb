class AddStepToAddressBook < ActiveRecord::Migration
  def self.up
    add_column :address_books, :step, :string, :default => "name"
  end

  def self.down
    remove_column :address_books, :step
  end
end
