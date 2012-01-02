class RenameFileToImportFileInAdressBook < ActiveRecord::Migration
  def self.up
    rename_column :address_books, :file, :import_file
  end

  def self.down
    rename_column :address_books, :import_file, :file
  end
end
