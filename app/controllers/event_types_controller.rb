class EventTypesController < ApplicationController
  before_action :find_event_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @event_types = EventType.all
    respond_with(@event_types)
  end

  def show
    respond_with(@event_type)
  end

  def new
    @event_type = EventType.new
    respond_with(@event_type)
  end

  def edit
  end

  def create
    @event_type = EventType.new(event_type_params)
    if @event_type.save
      redirect_to event_types_path, notice: "Successfully created EventType"
    else
      respond_with(@event_type)
    end
  end

  def update
    @event_type.update(event_type_params)
    # respond_with(@event_type)
    redirect_to event_types_path, notice: "Successfully updated EventType"
  end

  def destroy
    @event_type.destroy
    # respond_with(@event_type)
    redirect_to event_types_path, notice: "Successfully deleted EventType"
  end

  private
    def find_event_type
      @event_type = EventType.find(params[:id])
    end

    def event_type_params
      params.require(:event_type).permit(:description)
    end
end
