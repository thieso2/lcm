class ImportJobsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def index
    @imports = ImportJob.all
  end

  def show
    @import = ImportJob.find(params[:id])
    @scope_step = params[:step]
    @scope_rows = params[:rows]
  end

  def destroy
    @import = ImportJob.find(params[:id])
    @import.destroy
    respond_with(@import)
  end

  private
  def secure_params()
    params
    . require(:id)
  end

end

