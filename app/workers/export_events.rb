class ExportEvents
  require 'xlsx_export'

  MAPPING = {
    'eID' => 'eid',
    'eName' => 'shortname',
    'eBeschreibung' => 'title',
    'eOrt' => 'city',
    'eJahr' => 'year'
  }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, "Events",
      Event.joins(:location).order("eid").select("*"),
      MAPPING
  end

end
