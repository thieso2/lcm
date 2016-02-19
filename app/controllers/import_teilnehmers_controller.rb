class ImportTeilnehmersController < ApplicationController
  before_filter :authenticate_user!

  def new

  end

  def create
    # event = Event.find_by(id: secure_params[:event_id].to_i)
    file = secure_params[:file]
    # if event && file
    if file
      import = ImportJob.create!(
          original_filename: file.original_filename,
          temp_filename: file.tempfile.path,
          person_id: current_user.id)

      ImportExcelTeilnehmer.perform(import.id)    # perform_async
      redirect_to import_job_path(import.id)

    else
      @info = []
      flash[:error] =  "Grrrr"
    end
  end

  private
  def secure_params()
    params
    . require(:import_teilnehmer)
  end

end
