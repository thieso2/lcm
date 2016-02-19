# Imports Absolventen, Events and Assignments from an Excel File
class ImportExcelAbsolventen
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def self.perform(jobid)
    x = new
    x.perform jobid
  end

  def perform(jobid)
    # Initial load of database => disable PaperTrail
    PaperTrail.enabled = false

    PersonEventAssignment.delete_all
    PersonTeamAssignment.delete_all
    Event.delete_all
    Person.delete_all("id > 1")

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
