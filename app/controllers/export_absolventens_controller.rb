class ExportAbsolventensController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    file  =  Tempfile.new ["absolventen",".xlsx"]
    if file
      ExportExcelAbsolventen.export(file)
      send_file file, type: "application/xlsx"

      #send_data ExportExcelAbsolventen.export(file),
      #              filename: "absolventen.xlsx",
      #              type: "application/xls"
      #end
    else
      flash[:error] =  "Bitte eine Datei auswählen"
    end

  end

end
