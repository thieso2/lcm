class VisitorsController < ApplicationController
  
  def index
    @courses = Course.open    
  end
end
