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
  
  def self.read(file, event)
    self.new file, event
  end
  
  def initialize(file, event)
    @file = file
    @event = event
    @role = RoleType.find_by(description: "Attendee")
    read_teilnehmer     
  end

  private  
  def read_teilnehmer
    rows = XlsxImport.read @file.path, SHEET_TEILNEHMER
    #ActiveRecord::Base.transaction do
    #  ActiveRecord::Base.logger.silence do
        rows.each do |row|
          import_row row
        end
    #  end
    #end
  end
  
  def import_row(row)
    debugger
    unless p = find_person(row)
      p = Person.new
    end
    MAPPING.each {|col,field|
      # p.write_attribute(field.to_sym, row[col])
      p.send(field + "=", row[col])
    }    
    p.access = :person
    
    p.save!
    
    p.assign_to @event, @role
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