class DeliveriesController < ApplicationController
  def new
    @assignment = current_user.assignments.find params[:assignment_id]
    @delivery   = @assignment.deliveries.build
  end

  def create
    @assignment    = current_user.assignments.find params[:assignment_id]
    @delivery      = @assignment.deliveries.build params[:delivery]
    @delivery.user = current_user
    
    if @delivery.save
      redirect_to assignment_delivery_path(@assignment), :notice => t('flash.delivery_created')
    else
      render :new
    end
  end

  def edit
  end

  def show
    @delivery = Delivery.where(:user_id => current_user, :assignment_id => params[:assignment_id]).first
  end
end
