class RegionsController < ApplicationController

  before_action :find_region, only: [:show, :edit, :update, :destroy]

  def index
    @regions = Region.all
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      redirect_to regions_path, notice: "Successfully created Region"
    else
      respond_with(:region)
    end
  end

  def edit
  end

  def update
    @region.update(region_params)
    redirect_to regions_path, notice: "Successfully updated Region"
  end

  def destroy
    @region.destroy
    redirect_to regions_path, notice: "Successfully destroyes Region"
  end


  private
  def find_region
    @region = Region.find(params[:id])
  end

  def region_params
    params.require(:region).permit(:code, :region)
  end

end
