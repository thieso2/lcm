# Imports ATTENDEES From Excel Table AbsolventenKomplett.xls
class ImportAttendees
  
  SHEET_ATTENDEES = 1
    
  MAPPING = {
      "pID" => "pid",
      "Kommentar / wichtige Info" => "notes",
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
      "Zuordnung" => "region"
    }
      
  
    def self.read(file)
      self.new file
    end
    
    def initialize(file)
      @file = file
      read_attendees      
    end
    
    private
    def read_attendees
      rows = XlsxImport.read @file.path, SHEET_ATTENDEES
      ActiveRecord::Base.transaction do
        rows.each do |row|
          import_row row
        end
      end
      return rows.count
    end
    
    def import_row(row)
      p = Person.new
      MAPPING.each {|col,field|
        p.write_attribute(field.to_sym, row[col])
      }
            
      case row["Anrede"]
        when "Herr" 
          p.sex = :male
        when "Frau"
          p.sex = :female
        else
          p.sex = :other
      end
      
      case row["Land"]
        when "D"        
          p.country = "DE"
        when "", nil
          p.country = "DE"            
      end
      case row["Status"]
        when "DNC"
          p.do_not_contact = true
      end
      
      p.access = :person
      
      p.save!
        
    end
    
end