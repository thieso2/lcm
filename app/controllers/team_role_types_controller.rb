class TeamRoleTypesController < ApplicationController
  before_action :set_role_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @role_types = TeamRoleType.all
    respond_with(@role_types)
  end

  def show
    respond_with(@role_type)
  end

  def new
    @role_type = TeamRoleType.new
    respond_with(@role_type)
  end

  def edit
    # authorize @role_type
  end

  def create
    @role_type = TeamRoleType.new(role_type_params)
    flash[:notice] = 'RoleType was successfully created.' if @role_type.save
    respond_with(@role_type)
  end

  def update
    flash[:notice] = 'RoleType was successfully updated.' if @role_type.update(role_type_params)
    #respond_with(@role_type)
    redirect_to team_role_types_path
  end

  def destroy
    @role_type.destroy
    respond_with(@role_type)
  end

  private
    def set_role_type
      @role_type = TeamRoleType.find(params[:id])
    end

    def role_type_params
      params.require(:team_role_type).permit(:description)
    end
end
