class ReportController < ApplicationController

  def index
    @reports = Report.all
  end

  def show
    @report  = Report.find_by_url_name(params[:id])
    @query = @report.send(@report.url_name.to_sym)
    @results = @query.page(params[:page]).per(15)
  end
end
