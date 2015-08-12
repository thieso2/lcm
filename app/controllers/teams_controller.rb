class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  respond_to :html

  VISIBLE_ATTRIBUTES =
  %w( tid team_type shortname region startdate enddate )

  def index
    @teams = Team.search(params[:search]).order(startdate: :desc).take(20)
    respond_with(@teams)
  end

  def show
    # @assignments = @team.assignments.includes(:role_type).includes(:person)
    respond_with(@team)
  end

  def new
    @team = Team.new
    respond_with(@team)
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    @team.save
    respond_with(@team)
  end

  def update
    @team.update(team_params)
    respond_with(@team)
  end

  def destroy
    @team.destroy
    respond_with(@team)
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:team_type_id, :shortname, :location, :startdate, :enddate, :teamstate, :state)
    end
end
