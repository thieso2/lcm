# Imports COURSES(Events) From Excel Table AbsolventenKomplett.xls
class ImportEvents
    SHEET_EVENTS = 3

    MAPPING = {
      "eID" => "eid",
      "eName" => "setshortname",
      "eBeschreibung" => "title",
      "eOrt" => "city"
    }

    def self.read(file)
      me = self.new file
      me.read_events
    end

    def initialize(file)
      @file = file
    end

    def read_events
      msg = []
      rows = XlsxImport.read @file.path, SHEET_EVENTS
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.logger.silence do
          rows.each do |row|
            next if row["eID"].blank?
            msg << import_row(row)
          end
        end
      end
      return msg
    end

    private
    def import_row(row)
      c = Event.new
      MAPPING.each {|col,field|
        c.send(field + "=", row[col])
      }

      #c.event_type_id = 1
      unless row["eJahr"].blank?
        c.startdate = row["eJahr"] + row["eZeitraum"][0..1] + "01"
      else
        c.startdate = "20000101"
      end
      c.event_state = :closed

      puts c

      if c.save!
        return c
      end

    rescue => e
      puts "Error: #{e} #{e.backtrace}"
    end


end
