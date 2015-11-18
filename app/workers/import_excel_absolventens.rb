# Imports Absolventen, Events and Assignments from an Excel File
class ImportExcelAbsolventens
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def self.perform(jobid)
    x = new
    x.perform jobid
  end

  def perform(jobid)
    if Person.count < 5
      # Initial load of database => disable PaperTrail
      PaperTrail.enabled = false
    end

    import = ImportJob.find(jobid)
    ActiveRecord::Base.transaction { ImportAttendees.read(import) }
    ActiveRecord::Base.transaction { ImportEvents.read(import) }
    ActiveRecord::Base.transaction { ImportAssignments.read(import) }

    import.finish

    # enable PaperTrail again
    PaperTrail.enabled = true
    import
  end
end
