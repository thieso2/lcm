class ImportAbsolventensController < ApplicationController
  before_filter :authenticate_user!

  def new

  end

  def create
    file = secure_params[:file]
    if file
      import = ImportJob.create!(
          original_filename: file.original_filename,

          temp_filename: file.tempfile.path,
          user_id: current_user.id)

      # ImportExcelAbsolventens.perform(import.id)
      ImportExcelAbsolventens.perform_async(import.id)   # Sidekiq
      redirect_to import_job_path(import.id)
    else
      flash[:error] =  "Bitte eine Datei auswählen"
    end

  end

  private
  def secure_params()
    params
    . require(:import_absolventen)
  end

end
