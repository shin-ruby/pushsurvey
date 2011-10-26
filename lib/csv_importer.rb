
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
    @format_error = ""
    @uniqueness_error = ""
    @reader = FasterCSV.new(@string, :col_sep=>",")
    header = @reader.shift
    columns = {}
    if header && header.size == 1 && header[0].strip == "=" #default header
      columns[0] = "email"
      columns[1] = "firstname"
      columns[2] = "lastname"
      columns[3] = "name"
    else
      header.each_with_index do |col, index|
        columns[index] = Contact.find_alias_name(col)
      end
    end
    @reader.each { |row|
      contact = Contact.new
      row.each_with_index do |col, index|
        contact.send("#{columns[index]}=", col) if columns[index]
      end
      contact.address_book = address_book
      if (contact.validation_step = "format") && !contact.valid?
         @format_error << row.to_csv
      elsif (contact.validation_step = "uniqueness") && !contact.valid?
         @uniqueness_error << row.to_csv
      else
        contact.validation_step = nil
        contact.save!
      end
    }
    super
  end
end