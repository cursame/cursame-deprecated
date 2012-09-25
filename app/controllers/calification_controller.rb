class CalificationController < ApplicationController
  
  def index 
     @deliveries = @assignments.deliveries 
     @deliveries = Deliveries.all
  end

  def course
    @course ||= accessible_courses.find params[:course_id]
  end
 
end
