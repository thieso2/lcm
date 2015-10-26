# Imports Absolventen, Events and Assignments from an Excel File
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
    shortname = import.original_filename[/(.*)_/, 1]
    unless evt = Event.where(shortname: shortname).first
      evt = Event.create
      evt.setshortname=shortname
      evt.save!
    end
    evt
  end

end
