#
# Imports Teilnehmer(Absolventen) for a single Event from an Excel File
#
class ImportExcelTeilnehmer
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def self.perform(jobid)
    x = new
    x.perform jobid
  end

  def perform(jobid)
    import = ImportJob.find(jobid)
    if event =  find_or_create_event(import)
      ImportTeilnehmer.read(event, import)
    end
    import.finish

    import
  end


  private
  def find_or_create_event(import)
    unless evt = Event.where(shortname: Event.shortname_from_filename(import.original_filename) ).first
      evt = Event.create(filename: import.original_filename)
      evt.save!
    end
    evt
  end

end
