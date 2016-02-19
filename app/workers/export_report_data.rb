require 'axlsx'

class ExportReportData

  def self.export(name, data, to_file)
    p = Axlsx::Package.new

    mapping = data.first.attributes.keys.inject({}) do |hash, key|
      hash[key.to_sym] = I18n.t(key, scope: "Person")
      hash
    end

    XlsxExport.process p.workbook, name, data, mapping

    p.serialize  to_file
  end

end
