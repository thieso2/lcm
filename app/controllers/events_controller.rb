class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :html

  VISIBLE_ATTRIBUTES =
  %w( id shortname title location startdate enddate baseprice event_state )

  def index
    @events = Event.search(params[:search]).order(startdate: :desc).take(15)
    respond_with(@events)
  end

  def show
    # @assignments = @event.assignments.includes(:role_type).includes(:person)
    respond_with(@event)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event_type_id, :shortname, :location, :startdate, :enddate, :eventstate, :state)
    end
end
