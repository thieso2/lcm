class ExportAssignments

  MAPPING = {
    'zID' => 'id',
    'pID' => 'pid',
    'eID' => 'eid',
    'Event' => 'shortname'
  }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, "Assignments",
      PersonEventAssignment
        .joins(:person, :event)
        .order("eid, pid")
        .select("person_event_assignments.* ,pid,eid,shortname"),
      MAPPING
  end

end
