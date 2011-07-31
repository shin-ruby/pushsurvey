class Importer
  def import

  end
  def self.do_import(file)
    ext=file[file.rindex(".")+1..-1]
    Object.const_get((ext.capitalize + "Importer")).new(file).import
  end
end