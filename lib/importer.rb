class Importer
  def import

  end
  def self.do_import(file, address_book)
    ext=file[file.rindex(".")+1..-1]
    Object.const_get((ext.capitalize + "Importer")).new(file, address_book).import
  end
end