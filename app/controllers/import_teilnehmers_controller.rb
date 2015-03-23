class ImportTeilnehmersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    
  end
  
  def create
    @rows = []
    course = Course.find_by(id: params[:import_teilnehmer][:course_id].to_i)
    if course    
      file = params[:import_teilnehmer][:file]
      
      @rows = XlsxImport.read file.path, 1
      ImportTeilnehmerData.import @rows, course

    else
      flash[:error] =  "Grrrr"
    end
  end
end
