#
# Imports Assignments From Excel Table AbsolventenKomplett.xls
# Author  : K.D. Gundermann
# Date:   : 14.04.2015
#
class ImportAssignments

  SHEET_ASSIGNMENTS = 2

    def self.read(import)
      self.new import
    end

    def initialize(import)
      @import = import
      read_assignments
    end

    private
    def read_assignments
      @import.log :step, description: "Import Assignments: Load Excel File"
      begin
        rows = XlsxImport.read @import.temp_filename, SHEET_ASSIGNMENTS
      rescue XlsxImport::Error => e
        @import.log :error, e.to_s
        return
      end

      @import.log :step, description: "Import Assignments: Create Records"
      #ActiveRecord::Base.transaction do
        ActiveRecord::Base.logger.silence do
          rows.each do |row|
            next if row["zID"].blank?
            import_row(row)
          end
        end
      #end
    end

    def import_row(row)
        errors = []
        p = Person.where(:pid => row["pID"]).first
        errors <<  "Can not find Person with id: #{row["pID"]}"  unless p

        e = Event.where(:eid => row["eID"]).first
        errors <<  "Can not find Event with id: #{row["eID"]} " unless e

        if p && e
          p.assign_to_event(e, role_attendee)
          if p.valid?
            p.save!
          else
           errors = p.errors
          end
        end
        @import.log :row, rawdata: row, message: errors
    end

    def role_attendee
      @role_attendee  ||= EventRoleType.where(:description => "Attendee").first
    end

end
