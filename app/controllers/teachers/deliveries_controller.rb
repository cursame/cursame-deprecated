class Teachers::DeliveriesController < ApplicationController
  set_tab :deliveries, :only => %w(index)
  
  def index
    @assignment = current_user.manageable_assignments.find params[:assignment_id]
    @deliveries = @assignment.deliveries
    @course     = @assignment.course
  end

  def show
   
    @delivery   = current_user.manageable_deliveries.find params[:id]   
    @calificationem = @delivery.calificationem   
    @assignment = @delivery.assignment
    @course     = @assignment.course
    @comments   = @delivery.comments.order("created_at DESC").page(params[:page]).per(10)
    render 'students/deliveries/show'
  end

  def update
    @delivery = current_user(:assignment_id => params[:assignment_id]).first
    @assignment = @delivery.assignment
    @course     = @assignment.course
    @delivery.save
  end
  
  def calification_group
      @assignment = current_user.manageable_assignments.find params[:assignment_id]
      @deliveries = @assignment.deliveries
  end
end
