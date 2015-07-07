# Imports Assignments From Excel Table AbsolventenKomplett.xls
class ImportAssignments
  
  SHEET_ASSIGNMENTS = 2
      
    def self.read(file)
      self.new file
    end
    
    def initialize(file)
      @file = file
      read_assignments  
    end
    
    private
    def read_assignments
      infos = []
      rows = XlsxImport.read @file.path, SHEET_ASSIGNMENTS
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.logger.silence do
        rows.each do |row|
          next if row["zID"].blank?
          infos << import_row(row)
        end
      end
      end
      return infos
    end
    
    def import_row(row)
        p = Person.where(:pid => row["pID"]).first
        return "Can not find Person with id: #{row["pID"]}"  unless p          
        
        e = Event.where(:eid => row["eID"]).first        
        return "Can not find Event with id: #{row["eID"]} " unless e
                
        p.assign_to(e, role_attendee)
        p.save!
        return "Person #{p} assigned to #{e}"
    end
    
    def role_attendee
      @role_attendee  ||= RoleType.where(:description => "Attendee").first
    end
    
end