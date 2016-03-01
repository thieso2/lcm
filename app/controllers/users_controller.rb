class UsersController < ApplicationController
  respond_to :html

  before_action :find_user, only: [:show, :edit, :update, :destroy]

  VISIBLE_ATTRIBUTES = %w(id email current_sign_in_at last_sign_in_at sign_in_count)

  def index
    authorize User
    @user = User.all
  end

  def new
    @user = User.new
    authorize @user
  end


  def create
    @user = User.create(safe_params)
    authorize @user
    if @user.save
      redirect_to users_path, notice: "Successfully created User"
    else
      respond_with(@user)
    end
  end

  def show
  end

  def edit

  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def safe_params
    params.require(:user).permit(:email,:password,:password_confirmation)
  end
end
