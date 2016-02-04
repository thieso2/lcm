require 'axlsx'

class XlsxExport

  def self.process(xls_workbook,sheetname, data, mapping)
    sheet   = xls_workbook.add_worksheet(name: sheetname)
    header  = xls_workbook.styles.add_style bg_color: '2F75B5', fg_color: 'FFFFFF', b: true

    sheet.add_row mapping.keys,  style: header

    data.each do |row|
      sheet.add_row map(row, mapping)
    end
  end

  private
  def self.map(row, mapping)
    mapping.inject([]) do |array, (key,value)|
      array << row.send(value)
    end
  end

end
