class DeliveriesController < ApplicationController
  def show
    @delivery = current_user.deliveries.where(:assignment_id => params[:assignment_id]).first
    @comments = @delivery.comments.order("created_at DESC").page(params[:page]).per(10)
  end

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
    @delivery = current_user.deliveries.where(:assignment_id => params[:assignment_id]).first
  end
  
  def update
    @delivery = current_user.deliveries.where(:assignment_id => params[:assignment_id]).first
    if @delivery.update_attributes params[:delivery]
      redirect_to assignment_delivery_path(@delivery.assignment), :notice => t('flash.delivery_updated')
    else
      render :new
    end
  end
end
