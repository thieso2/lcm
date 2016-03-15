#
# Imports Assignments From Excel Table AbsolventenKomplett.xls
# Author  : K.D. Gundermann
# Date:   : 14.04.2015
#
class ImportAssignments

  SHEET_ASSIGNMENTS = "Assignments"

    def self.read(import)
      self.new import
    end

    def initialize(import)
      @import = import
      read_assignments
    end

    private
    def read_assignments
      step = @import.log_step description: "Import Assignments: Load Excel File"
      begin
        rows = XlsxImport.read_sheet @import.temp_filename, SHEET_ASSIGNMENTS
      rescue XlsxImport::Error => e
        @import.log_error e.to_s
        return
      end
      step.totalrows = rows.count

      @import.log_step description: "Import Assignments: Create Records"
      #ActiveRecord::Base.transaction do
        ActiveRecord::Base.logger.quietly do
          rows.each do |row|
            next if row["zID"].blank?
            import_row(row)
          end
        end
      #end
    end

    def import_row(row)
        errors = []
        p = Person.where(:id => row["pID"]).first
        errors <<  "Can not find Person with id: #{row["pID"]}"  unless p

        e = Event.where(:id => row["eID"]).first
        errors <<  "Can not find Event with id: #{row["eID"]} " unless e

        if p && e
          p.assign_to_event(e, role_attendee)
          if p.valid?
            p.save!
          else
           errors = p.errors
          end
        end
        @import.log_row rawdata: row, message: errors
    end

    def role_attendee
      @role_attendee  ||= EventRoleType.where(:description => "Attendee").first
    end

end
