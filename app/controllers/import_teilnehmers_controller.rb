class ImportTeilnehmersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    
  end
  
  def create
    event = Event.find_by(id: secure_params[:event_id].to_i)
    file = secure_params[:file]
    if event && file
      @info = ImportTeilnehmer.read(file, event)
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
