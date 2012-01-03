class CsvImporter < Importer
  attr_accessor :address_book

  def initialize(address_book, options)

    if options[:s3_key]
       @s3_key = options[:s3_key]
    elsif
       @string = options[:string]
    end
     self.address_book = address_book
  end
  def import
    require 'faster_csv'
    require 'address_book'
    require 'contact'

    @format_error = ""
    @uniqueness_error = ""
    if @s3_key.present?
      url = ImporterUploader.new.direct_fog_url +  @s3_key
      Excon.ssl_verify_peer = false
      response = Excon.get(url)
      @reader = FasterCSV.new(response.body,:col_sep=>",")
    else
      @reader = FasterCSV.new(@string, :col_sep=>",")
    end

    header = nil
    begin
      header = @reader.shift
    rescue FasterCSV::MalformedCSVError => e
      @format_error << "header has formatting problem, please check your header"
      return super
    end
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
    loop do
      line = 0
      begin
        line += 1
        break unless row = @reader.shift

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
          begin
            contact.validation_step = nil
            contact.save!
          rescue
            #some error happen, most of time encoding problem
            @format_error << row.to_csv
          end
        end
      rescue FasterCSV::MalformedCSVError => e
        @format_error << "line #{line}"
      end

    end
    super
  end
  def perform

  end
end