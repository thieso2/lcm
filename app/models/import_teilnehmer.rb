class ImportTeilnehmer
  #  Imports from Excel Table LMFRK...
  
  MAPPING = {
    "PID" => "pid",
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
  
  
  def self.import(rows, course)    
    role = RoleType.find_by(description: "Attendee")
    rows.each do |row|
      p = Person.new
      MAPPING.each {|col,field|
        p.write_attribute(field.to_sym, row[col])
      }
      debugger
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
      end
      p.access = :person
      
      p.save!
      
      p.assign_to course, role
    end
  end
end