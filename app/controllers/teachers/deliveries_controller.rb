class Teachers::DeliveriesController < ApplicationController
  set_tab :deliveries, :only => %w(index)
  
  def index
    @assignment = current_user.manageable_assignments.find params[:assignment_id]
    @deliveries = @assignment.deliveries
    @course     = @assignment.course
  end

  def show
    @delivery = current_user.manageable_deliveries.find params[:id]
    @comments = @delivery.comments.order("created_at DESC").page(params[:page]).per(10)
    render 'students/deliveries/show'
  end
end
