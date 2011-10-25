
class CsvImporter < Importer
  attr_accessor :address_book

  def initialize(address_book, options)
    if options[:file]
       @string = File.read(options[:file])
    elsif
       @string = options[:string]
    end
     self.address_book = address_book
  end
  def import
    @reader = FasterCSV.new(@string, :col_sep=>",")
    header = @reader.shift
    columns = {}
    header.each_with_index do |col, index|
      columns[index] = Contact.find_alias_name(col)
    end
    @reader.each { |row|
      contact = Contact.new
      row.each_with_index do |col, index|
        contact.send("#{columns[index]}=", col) if columns[index]
      end
      contact.address_book = address_book
      contact.save!
    }
    super
  end
end