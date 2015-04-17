class CourseTypesController < ApplicationController
  before_action :find_course_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @course_types = GroupType.course.all
    respond_with(@course_types)
  end

  def show
    respond_with(@course_type)
  end

  def new
    @course_type = CourseType.new
    respond_with(@course_type)
  end

  def edit
  end

  def create
    @course_type = CourseType.new(course_type_params)
    if @course_type.save 
      redirect_to course_types_path, notice: "Successfully created CourseType"
    else
      respond_with(@course_type)
    end
  end

  def update
    @course_type.update(course_type_params)
    # respond_with(@course_type)
    redirect_to course_types_path, notice: "Successfully updated CourseType"
  end

  def destroy
    @course_type.destroy
    # respond_with(@course_type)
    redirect_to course_types_path, notice: "Successfully deleted CourseType"
  end

  private
    def find_course_type
      @course_type = GroupType.course.find(params[:id])
    end

    def course_type_params
      params.require(:course_type).permit(:description)
    end
end
