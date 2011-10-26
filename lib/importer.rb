class Importer
  #for DJ support
  attr_accessor :format_error, :uniqueness_error
  def perform
    import
  end
  def import
    PushMailer.import_result(address_book.user, self).deliver
  end
  def self.do_import(file, address_book)
    ext=file[file.rindex(".")+1..-1]
    Object.const_get((ext.capitalize + "Importer")).new(file, address_book).import
  end
end