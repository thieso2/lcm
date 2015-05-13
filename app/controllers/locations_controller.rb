class LocationsController < ApplicationController

  before_action :find_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to locations_path, notice: "Successfully created Location"
    else
      respond_with(:location)
    end
  end

  def edit
  end

  def update
    @location.update(location_params)
    redirect_to locations_path, notice: "Successfully updated Location"
  end

  def destroy
    @location.destroy
    redirect_to locations_path, notice: "Successfully destroyes Location"
  end


  private
  def find_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:code, :location)
  end

end
