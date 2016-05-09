#
# Imports COURSES(Events) From Excel Table AbsolventenKomplett.xls
# Author  : K.D. Gundermann
# Date:   : 14.04.2015
#
class ImportEvents

  SHEET_EVENTS = "Events"

  MAPPING = {
    'eID' => 'id',
    'eName' => 'filename',
    'eBeschreibung' => 'title',
    'eOrt' => 'city'
  }

  def self.read(import)
    self.new import
  end

  def initialize(import)
    @import = import
    read_events
  end

  private

  def read_events
    step = @import.log_step description: 'Import Events: Load Excel File'
    begin
      rows = XlsxImport.read_sheet @import.temp_filename, SHEET_EVENTS
    rescue XlsxImport::Error => e
      @import.log_error e.to_s
      return
    end
    step.totalrows = rows.count

    @import.log_step description: 'Import Events: Create Records'
    # ActiveRecord::Base.transaction do
    ActiveRecord::Base.logger.silence do
      rows.each do |row|
        next if row['eID'].blank?
        next if Event.exists?(row['eID'])
        import_row(row)
      end
    end
    # end
  end

  def import_row(row)
    c = Event.new
    MAPPING.each { |col, field| c.send(field + '=', row[col]) }

    #c.event_type_id = 1
    date = /[0-9]+/.match(row['eName']).to_s
    year = "20" + /[0-9][0-9]/.match(date).to_s
    month = /[0-9][0-9]([0-9][0-9])/.match(date)
    month = month ? month[1] : "01"
    month = "01" if month == "00"
    day = "01"
    c.startdate = year + month + day
    c.event_state = :closed

    if c.valid?
      c.save!
    end
    @import.log_row  row: row[:row], rawdata: row, importdata: c, message: c.errors.full_messages
  end
end
