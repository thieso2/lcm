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
    unless p = find_person(row)
      p = Person.new
    end
    MAPPING.each {|col,field|
      p.send(field + "=", row[col])
    }
    if p.valid?
      p.save!
      p.assign_to_event @event, @role
    end
    @import.log :row, row: row[:row], rawdata: row, importdata: p, message: p.errors.full_messages
  end

  def find_person(row)
    if pid=row[:PID] &&  p = Person.where(pid: pid).first
      return p
    end
    if p = Person.where(country: row[:Land]).where(lastname: row[:Nachname]).where(firstname: row[:Vorname]).first
      return p
    end
  end

end
