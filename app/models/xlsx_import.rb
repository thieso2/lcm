class XlsxImport
  require 'creek'
  #require 'remote_table'

  class Error < StandardError
  end

  def self.read filename, sheetid
    xls = self.new
    xls.read filename, sheetid
  end


  def read filename, sheetid
    begin
      creek = Creek::Book.new filename
    rescue Zip::Error => e
      raise XlsxImport::Error.new(e)
    end

    sheet = creek.sheets[sheetid]
    puts "reading #{sheet.name}"

    rows = []
    sheet.rows_with_meta_data.each do |row|
      if row["r"] == "1"
        read_colnames row
      else
        rows << with_colnames(row)
      end
    end
    rows
  end

  private
  def read_colnames(row)
    cells = row["cells"]
    @cols = {}
    cells.each {|key,value|
      @cols[strip_row(key)] = value
    }
  end

  def with_colnames(row)
    cells = row["cells"]
    hash = { row: row["r"] }
    cells.each {|key,value|
      cellkey = @cols[strip_row(key)]
      hash[cellkey] =  value
    }
    hash
  end

  def strip_row(cellname)
    cellname.gsub(/[0-9]*/, '')
  end

end
