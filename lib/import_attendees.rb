#
# Imports ATTENDEES From Excel Table AbsolventenKomplett.xls
# Author: K.D. Gundermann
# Date  : 14.04.2015
#
class ImportAttendees

  SHEET_ATTENDEES = 1

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
      "Zuordnung" => "region",
      "Kommentar / wichtige Info" => "notes"
    }


    def self.read(import, file)
      self.new import, file
    end

    def initialize(import, file)
      @import = import
      @file = file
      @step = ImportStep.new(description: "Import Attendees")
      @import.import_step << @step
      read_attendees
    end

    private
    def read_attendees
      rows = XlsxImport.read @file.path, SHEET_ATTENDEES
      #ActiveRecord::Base.transaction do
        ActiveRecord::Base.logger.silence do
          rows.each do |row|
            @step.import_row << import_row(row)
          end
        end
      #end
    end

    def import_row(row)
      p = Person.new
      MAPPING.each {|col,field|
        p.send(field + "=", row[col])
      }

      r = ImportRow.new(rawdata: row, importdata: p)
      if p.valid?
        p.save!
      else
        r.message p.errors
      end
      return r
    end

end
