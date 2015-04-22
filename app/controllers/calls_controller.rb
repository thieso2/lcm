class CallsController < ApplicationController
  
  def index
    redirect_to root_path
  end
  
  def new
    @call = Call.new
    if params[:person]
      @call.person_id = params[:person].to_i
    end
    @call.caller_id = current_user.id
    
  end
  
  def create
    @call = Call.new(safe_params)
    if @call.save
      redirect_to person_path(@call.person), notice: "Successfully created Call"
    else
      respond_with(@call)
      
    end    
  end
  
  private
  def safe_params
    params.require(:call).permit(:person_id, :date, :caller_id, :info)
  end
end