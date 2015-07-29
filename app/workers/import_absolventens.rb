class ImportAbsolventens
  include Sidekiq::Worker

  def self.perform(jobid)
      if Person.count < 5
        # Initial load of database
        # disable PaperTrail
        PaperTrail.enabled = false
      end

      import = ImportJob.find(jobid)
      ImportAttendees.read(import)
      ImportEvents.read(import)
      ImportAssignments.read(import)
      import.finish

      # enable PaperTrail again
      PaperTrail.enabled = true
      import
  end

end
