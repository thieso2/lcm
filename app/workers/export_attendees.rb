class ExportAttendees
  require 'xlsx_export'

  MAPPING = {
      "pID" => "pid",
      "Anrede" => "salutation",
      "Nachname" => "lastname",
      "Vorname" => "firstname",
      "Straße" => "street",
      "PLZ" => "zip",
      "Ort" => "city",
      "Land" => "country",
      "Telefon Privat"  => "phone_private",
      "Telefon Arbeit"  => "phone_work",
      "Telefon Mobil"   => "phone_mobile",
      "eMail" => "email",
      "Zuordnung" => "code",
      "Kommentar / wichtige Info" => "notes"
    }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, "Attendees",
      Person.joins(:region).order("lastname, firstname").select("*"),
      MAPPING
  end

end
