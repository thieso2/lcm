class ExportAttendees
  require 'xlsx_export'

  MAPPING = {
      "pID" => "pid",
      "Anrede" => "salutation",
      "Nachname" => "lastname",
      "Vorname" => "firstname",
      "Rufname" => "callby",
      "Titel" => "title",
      "Straße" => "street",
      "HNr" => "housenumber",
      "PLZ" => "zip",
      "Ort" => "city",
      "Land" => "country",
      "Geb.Datum" => "birthday",
      "Telefon Privat"  => "phone_private",
      "Telefon Arbeit"  => "phone_work",
      "Telefon Mobil"   => "phone_mobile",
      "eMail" => "email",
      "Zuordnung" => "code",
      "Kommentar / wichtige Info" => "notes"
    }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, "Attendees",
      Person.joins("LEFT JOIN regions ON regions.id = people.region_id").order("lastname, firstname").select("*"),
      MAPPING
  end

end
