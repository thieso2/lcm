require 'axlsx'

class ExportExcelAbsolventen

  def self.export(to_file)
    p = Axlsx::Package.new
    wb = p.workbook

    ExportAttendees.process(wb)
    ExportEvents.process(wb)
    ExportAssignments.process(wb)

    p.serialize  to_file
    #p.to_stream.read
  end

end
