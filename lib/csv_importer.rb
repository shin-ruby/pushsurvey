
class CsvImporter < Importer
  def initialize(file)
     @reader = FasterCSV.new(File.new(file), :col_sep=>"\t")
    #@reader = FasterCSV.new(File.new(file))
  end
  def import
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
      contact.save!
    }

  end
end