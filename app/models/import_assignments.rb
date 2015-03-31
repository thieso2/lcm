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
        rows.each do |row|
          next if row["zID"].blank?
          import_row infos,row
        end
      end
      return infos
    end
    
    def import_row(infos, row)
        p = Person.where(:pid => row["pID"]).first
        unless p
          infos << "Can not find Person with id: #{row["pID"]}"
          next
        end
        e = Event.where(:eid => row["eID"]).first
        unless e
          infos << "Can not find Event with id: #{row["eID"]} " 
          next
        end
        p.assign_to(e, role_attendee)
        p.save!
        infos << "Person #{p} assigned to #{e}"
    end
    
    def role_attendee
      @role_attendee  ||= RoleType.where(:description => "Attendee").first
    end
    
end