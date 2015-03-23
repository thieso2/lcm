# Imports COURSES(Events) From Excel Table AbsolventenKomplett.xls
class ImportCourses
    SHEET_COURSES = 3

    MAPPING = {
      "eName" => "shortname",
      "eBeschreibung" => "title",
      "eOrt" => "location"
    }
    
    def self.read(file)
      self.new file
    end
    
    def initialize(file)
      @file = file
      read_courses
    end
    
    private
    def read_courses
      rows = XlsxImport.read @file.path, SHEET_COURSES
      rows.each do |row|
        next if row["eID"].blank?
        c = Course.new
        MAPPING.each {|col,field|
          c[field.to_sym] = row[col]
        }
        
        c.group_type_id = 1
        unless row["eJahr"].blank?
          c.startdate = row["eJahr"] + row["eZeitraum"][0..1] + "01"
        else
          c.startdate = "20000101"
        end
        c.course_state = :closed
        
        c.save!
        puts c
      end

    end
    

end