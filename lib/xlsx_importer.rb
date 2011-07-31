class XlsxImporter < Importer
  def initialize(file)
    @s = Excelx.new(file)
  end

  def import
    #finding out whether first row is column headers
    header_row = 1
    @s.first_row.upto(@s.last_row) do |row|
      count_not_nil = 0
      header_row = row
      @s.first_column.upto(@s.last_column) do |column|
        count_not_nil += 1 if @s.cell(row, column)
      end
      break if count_not_nil > 2
    end

    last_row = @s.last_row


    header_row.upto(@s.last_row) do |row|
      count_not_nil = 0
      @s.first_column.upto(@s.last_column) do |column|
        count_not_nil += 1 if @s.cell(row, column)
      end
      if count_not_nil == 0
        last_row = row - 1
        break
      end
    end
    #puts "last row is #{last_row}"

      #puts "header row is #{header_row}"

    columns = {}

    header_row.upto(last_row) do |row|
      contact = Contact.new
      if row == header_row #handling header_row info
        @s.first_column.upto(@s.last_column) do |column|

          columns[column] = Contact.find_alias_name(@s.cell(row, column))
        end
      else

        @s.first_column.upto(@s.last_column) do |column|
          next if columns[column].downcase == "id"
          contact.send("#{columns[column]}=", @s.cell(row, column))
        end
        contact.save!

      end
    end

  end
end