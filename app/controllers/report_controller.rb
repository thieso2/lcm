class ReportController < ApplicationController

  def index
    @reports = Report.all
  end

  def show
    @report  = Report.find_by_url_name(params[:id])
    @results = Report.send(@report.url_name)
  end
end
