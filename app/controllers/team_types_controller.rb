class TeamTypesController < ApplicationController
  before_action :find_course_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @team_types = TeamType.all
    respond_with(@team_types)
  end

  def show
    respond_with(@team_type)
  end

  def new
    @team_type = TeamType.new
    respond_with(@team_type)
  end

  def edit
  end

  def create
    @team_type = TeamType.new(course_type_params)
    if @team_type.save
      redirect_to team_types_path, notice: "Successfully created CourseType"
    else
      respond_with(@team_type)
    end
  end

  def update
    @team_type.update(course_type_params)
    # respond_with(@team_type)
    redirect_to course_types_path, notice: "Successfully updated CourseType"
  end

  def destroy
    @team_type.destroy
    # respond_with(@team_type)
    redirect_to course_types_path, notice: "Successfully deleted CourseType"
  end

  private
    def find_course_type
      @team_type = TeamType.find(params[:id])
    end

    def course_type_params
      params.require(:course_type).permit(:description)
    end
end
