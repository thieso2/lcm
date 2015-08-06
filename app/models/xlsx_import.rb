# Import of Xlsx-File
#
class XlsxImport
  require 'creek'
  # require 'remote_table'

  class Error < StandardError
  end

  def self.read(filename, sheetid)
    puts "Import #{filename}"
    xls = self.new
    xls.read_creek filename, sheetid
    # xls.read_dullard filename, sheetid
  end

  def read_dullard(filename, sheetid)
    RubyProf.start
    begin
      workbook = Dullard::Workbook.new filename
    rescue Zip::Error => e
      raise XlsxImport::Error.new(e)
    end
    result = RubyProf.stop
    printer = RubyProf::FlatPrinter.new(result)
    printer.print(STDOUT)

    sheet = workbook.sheets[sheetid]
    rows = []
    sheet.rows.each do |row|
      puts row
    end

    sheet.rows.each_with_index do |row, r|
      if r == 0
        @col_names = row
      else
        rows << with_dullard_colnames(row)
      end
    end
    rows
  end

  def with_dullard_colnames(row)
    debugger
    hash = {}
    row.each_with_index do |col, i|
      hash[@col_names[i]] = col
    end
    hash
  end

  # -------------------------------------------------------------------------

  def read_creek(filename, sheetid)
    #RubyProf.start
    begin
      creek = Creek::Book.new filename
    rescue Zip::Error => e
      raise XlsxImport::Error.new(e)
    end
    #result = RubyProf.stop
    #printer = RubyProf::FlatPrinter.new(result)
    #printer.print(STDOUT)


    sheet = creek.sheets[sheetid]
    puts "reading #{sheet.name}"

    rows = []
    # sheet.rows_with_meta_data.each do |row|
    sheet.rows.each_with_index do |row, index|
#      if row["r"] == "1"
      if index == 0
        read_colnames row
      else
        rows << { row: index }.merge(with_colnames(row))
      end
    end
    rows
  end

  private

  def read_colnames(row)
    cells = row   # ["cells"]
    @cols = {}
    cells.each {|key,value|
      @cols[strip_row(key)] = value
    }
  end

  def with_colnames(row)
    cells = row   # ["cells"]
    # hash = { row: row["r"] }
    hash = {}
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
