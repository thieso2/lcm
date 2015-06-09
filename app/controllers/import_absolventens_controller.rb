class ImportAbsolventensController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    
  end
  
  def create
    file = secure_params[:file]
    @info = ""
    if file
      @info << ImportAttendees.read(file)
      @info << ImportEvents.read(file)
      @info << ImportAssignments.read(file)
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