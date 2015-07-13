class ImportAbsolventensController < ApplicationController
  before_filter :authenticate_user!

  def new

  end

  def create
    file = secure_params[:file]
    if file
      import = Import.create!(fromfile: file.original_filename, starttime: DateTime.now, user: current_user)
      ImportAttendees.read(import, file)
      # ImportEvents.read(import, file)
      # ImportAssignments.read(file)
      binding.pry
      redirect_to import_path(import)
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
