class PeopleController < ApplicationController
  before_filter :authenticate_user!

  before_action :find_person, only: [:show, :edit, :update, :destroy]
  after_action  :verify_authorized

  respond_to :html

  VISIBLE_ATTRIBUTES =
    %w(sex firstname lastname email country city street
                    phone_private phone_work phone_mobile)

  def index
    @persons = Person.search(params).take(15)
    authorize Person
  end

  def show
    authorize @person
  end

  def new
    @person = Person.new
    authorize @person
    # respond_with @person
  end

  def create
    @person = Person.new(secure_params)
    authorize @person

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @person = Person.find(params[:id])
    authorize @person
    respond_with @person
  end

  def update

    authorize @person
    if @person.update(secure_params)
      respond_with(@person)
    else
      render :edit
    end

    #if @person.update_attributes(secure_params)
    #  redirect_to person_path, :notice => "Person updated."
    #else
    #  #format.html { render :edit, @person}
    #  redirect_to edit_person_path(@person), :alert => "Unable to update person. #{@person.errors.messages}"
    #end
  end

  def destroy
    authorize @person
    @person.destroy
    redirect_to person_path, :notice => "Person deleted."
  end

  private
  def find_person
    @person = Person.find(params[:id])
  end

  def secure_params
    params
    . require(:person)
    . permit(:firstname, :lastname, :sex, :country,
              :zip, :city, :street, :email,
              :phone_private, :phone_work, :phone_mobile,
              :do_not_contact, :access, :password)
  end


end
