require 'axlsx'

class ExportExcelAbsolventen

  def export(to_file)
    p = Axlsx::Package.new
    wb = p.workbook

    ExportAttendees.process(wb)
    ExportEvents.process(wb)
    ExportAssignments.process(wb)

    p.serialize to_file
  end

end
