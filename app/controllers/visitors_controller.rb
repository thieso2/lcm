class VisitorsController < ApplicationController
  
  def index
    @events = Event.open    
  end
end
