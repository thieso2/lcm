#
# Imports Teilnehmer from Excel Table LMFRK...Teilnehmerliste
# Author: K.D. Gundermann
# Date  : 14.04.2015
#

class ImportTeilnehmer

  SHEET_TEILNEHMER = 1

  MAPPING = {
    "PID" => "pid",
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
    "EMail" => "email"
  }

  def self.read(event, import)
    self.new event, import
  end

  def initialize(event, import)
    @event  = event
    @import = import
    @role = EventRoleType.where(description: "Attendee").first
    read_teilnehmer
  end

  private
  def read_teilnehmer
    step = @import.log(:step, description: "Import Teilnehmer: Load Excel File")
    begin
      rows = XlsxImport.read @import.temp_filename, SHEET_TEILNEHMER
    rescue XlsxImport::Error => e
      @import.log :error, e.to_s
      return
    end

    step.totalrows = rows.count
    step = @import.log(:step, description: "Import Teilnehmer: Update Records")
    #ActiveRecord::Base.transaction do
    ActiveRecord::Base.logger.silence do
        rows.each do |row|
          import_row(row)
        end
    end
    #end
  end

  def import_row(row)
    if p = find_person(row)
      MAPPING.each {|col,field|
        p.send(field + "=", row[col])
      }
      if p.valid?
        p.save!
        p.assign_to_event @event, @role
      end
      @import.log :row, row: row[:row], rawdata: row, importdata: p, message: p.errors.full_messages
    else
      @import.log :row, row: row[:row], rawdata: row, message: show_duplicates(row)
    end
  end

  def find_person(row)
    if pid=row["PID"].to_i && pid && pid > 0
      if p = Person.where(pid: pid).first
        return p
      end
    end

    country = row["Land"]
    country = "DE" if country = "D"
    query1 = Person.where(country: country).where(lastname: row["Nachname"]).where(firstname: row["Vorname"])
    query2 = query1.where(zip: row["PLZ"])
    if query1.count == 0
      return Person.new
    elsif query1.count == 1
      return query1.first
    elsif query2.count == 1
      return query2.first
    else
      return nil
    end
  end

  def show_duplicates(row)
    country = row["Land"]
    country = "DE" if country = "D"
    query = Person.where(country: country).where(lastname: row["Nachname"]).where(firstname: row["Vorname"]).where(zip: row["PLZ"])
    query = query.select([:pid, :lastname, :firstname, :country, :zip, :street])
    return  "Person '#{row["Nachname"]} #{row["Vorname"]}' nicht genau bestimmbar.\nÄhnliche Personen:" + query.all.to_a.join("<br>")
  end

end
