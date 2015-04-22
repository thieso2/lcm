class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignment
  def index
    # Don't allow to show all assignments
    # @assignments = Assignment.all
    redirect_to events_path
  end

  # GET /assignment/1
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
  def destroy
    @assignment.destroy    
    respond_to do |format|
      format.html { redirect_to event_path(@assignment.group_id), notice: "Assignment for '#{@assignment.person}' was successfully destroyed." }
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
