class ExportAttendees
  require 'xlsx_export'

  MAPPING = {
      "pID" => "id",
      "Kommentar / wichtige Info" => "notes",
      "Status" => "state",
      "Datum" => "date",
      "Nachname" => "lastname",
      "Vorname" => "firstname",
      "Rufname" => "callby",
      "Anrede" => "salutation",
      "Titel" => "title",
      "Geb.Datum" => "birthday",
      "Straße" => "street",
      "HNr" => "housenumber",
      "PLZ" => "zip",
      "Ort" => "city",
      "Land" => "country",
      "Telefon Privat"  => "phone_private",
      "Telefon Arbeit"  => "phone_work",
      "Telefon Mobil"   => "phone_mobile",
      "eMail" => "email",
      "Zuordnung" => "code"
    }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, "Attendees",
      Person.joins("LEFT JOIN regions ON regions.id = people.region_id").order("lastname, firstname").select("*"),
      MAPPING
  end

end
