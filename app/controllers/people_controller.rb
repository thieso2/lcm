class PeopleController < ApplicationController
  before_filter :authenticate_user!

  before_action :find_person, only: [:show, :edit, :update, :destroy]
  after_action  :verify_authorized

  respond_to :html

  VISIBLE_ATTRIBUTES =
    %w(id title sex firstname callby lastname birthday email country zip city street housenumber
                    state date
                    phone_private phone_work phone_mobile region ooa_es ooa_sem)

  def index
    @persons = Person.search(filter_params).take(15)
    authorize Person
  end

  def show
    authorize @person
    case params[:person_tabs_selected_tab]
    when 'person', nil then
      @data = @person
      per_page = 1
    when 'events' then
      @data = @person.event_assignments
      per_page = 8
    when 'teams'
      @data = @person.team_assignments
      per_page = 8
    when 'calls'
      @data = @person.calls
      per_page = 10
    when 'history'
      @data = @person.versions
      per_page = 1
    else
      @data = nil
    end

    if @data.respond_to? :page
      @data = @data.page(params[:page]).per(per_page)
    end

  end

  def new
    @person = Person.new
    authorize @person
    # respond_with @person
  end

  def create
    @person = Person.new(secure_create_params)
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
    if @person.update(secure_update_params)
      # respond_with(@person, :notice => "Person updated.")
      redirect_to person_path(person_tabs_selected_tab: 'history'), :notice => "Person updated."
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

  def secure_update_params
    params
      .require(:person)
      .permit(:title, :firstname, :lastname, :callby,
              :birthday, :sex, :country,
              :zip, :city, :street, :housenumber, :email,
              :state, :date,
              :phone_private, :phone_work, :phone_mobile,
              :do_not_contact, :ooa_es, :ooa_sem,
              :region)
  end
  def secure_create_params
    secure_update_params.permit(:id)
  end

  def filter_params
    if params[:person]
      @filter = params.require(:person)
    else
      @filter = params
    end
    @filter.permit(:id, :lastname, :country, :zip, :city)
  end

end
