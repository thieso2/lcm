class ReportController < ApplicationController

  def index
    @reports = Report.all
  end

  def show
    @report  = Report.find_by_url_name(params[:id])
    #@query = @report.send(@report.url_name.to_sym)
    #@results = @query.page(params[:page]).per(15)
    @query   = @report.send(@report.url_name)
    @count   = @query.count(:id)
    @results = @query.page(params[:page]).per(15)
  end

  def export
    report  = Report.find(params[:report_id])
    query   = report.send(report.url_name)

    file  =  Tempfile.new ["Report_#{report.url_name}" ,".xlsx"]
    if file
      ExportReportData.export(report.name, query, file)

      send_file file, type: "application/xlsx"
    end

  end

end
