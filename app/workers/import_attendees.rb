#
# Imports ATTENDEES From Excel Table AbsolventenKomplett.xls
# Author: K.D. Gundermann
# Date  : 14.04.2015
#
class ImportAttendees
  require 'xlsx_import'

  SHEET_ATTENDEES = 1

  MAPPING = {
      "pID" => "id",
      "Anrede" => "salutation",
      "Titel" => "title",
      "Nachname" => "lastname",
      "Vorname" => "firstname",
      "Rufname" => "callby",
      "Straße" => "street",
      "HNr" => "housenumber",
      "PLZ" => "zip",
      "Ort" => "city",
      "Land" => "country",
      "Geb.Datum" => "birthday",
      "Status" => "state",
      "Datum" => "date",
      "Telefon Privat"  => "phone_private",
      "Telefon Arbeit"  => "phone_work",
      "Telefon Mobil"   => "phone_mobile",
      "eMail" => "email",
      "Zuordnung" => "region",
      "Kommentar / wichtige Info" => "notes"
    }


    def self.read(import)
      self.new import
    end

    def initialize(import)
      @import = import
      read_attendees
    end

    private
    def read_attendees
      step = @import.log(:step, description: "Import Attendees: Load Excel File")
      begin
        rows = XlsxImport.read_sheet @import.temp_filename, SHEET_ATTENDEES
      rescue XlsxImport::Error => e
        @import.log :error, e.to_s
        return nil
      end

      step.totalrows = rows.count

      step = @import.log(:step, description: "Import Attendees: Create Records")
      #ActiveRecord::Base.transaction do
        ActiveRecord::Base.logger.silence do
          rows.each do |row|
            import_row(row)
          end
        end
      #end
    end

    def import_row(row)
      p = Person.new
      MAPPING.each {|col,field|
        p.send(field + "=", row[col])
      }

      p.valid? && p.save!

      @import.log :row, row: row[:row], rawdata: row, importdata: p, message: p.errors.full_messages
    end

end
