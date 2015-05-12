class EventTypesController < ApplicationController
  before_action :find_course_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @event_types = GroupType.event.all
    respond_with(@event_types)
  end

  def show
    respond_with(@event_type)
  end

  def new
    @event_type = GroupType.new
    respond_with(@event_type)
  end

  def edit
  end

  def create
    @event_type = GroupType.new(course_type_params)
    if @event_type.save 
      redirect_to event_types_path, notice: "Successfully created CourseType"
    else
      respond_with(@event_type)
    end
  end

  def update
    @event_type.update(course_type_params)
    # respond_with(@event_type)
    redirect_to course_types_path, notice: "Successfully updated CourseType"
  end

  def destroy
    @event_type.destroy
    # respond_with(@event_type)
    redirect_to course_types_path, notice: "Successfully deleted CourseType"
  end

  private
    def find_course_type
      @event_type = GroupType.event.find(params[:id])
    end

    def course_type_params
      params.require(:course_type).permit(:description)
    end
end
