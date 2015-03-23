class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignment
  # GET /assignment.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignment/1
  # GET /assignment/1.json
  def show
  end

  # GET /assignment/new
  def new
    @assignment = Assignment.new
    if params[:person]
      @assignment.person_id = params[:person].to_i
    end
    if params[:course]      
      @assignment.course_id = params[:course].to_i
    end
    
    
  end

  # GET /assignment/1/edit
  def edit
  end

  # POST /assignment
  # POST /assignment.json
  def create
    @assignment = Assignment.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignment/1
  # PATCH/PUT /assignment/1.json
  def update
    respond_to do |format|
      if assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment/1
  # DELETE /assignment/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignment_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:person_id, :course_id, :role_type_id)
    end
end
