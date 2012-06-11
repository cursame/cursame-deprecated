module Students
  class DeliveriesController < ApplicationController
    def show
      @delivery   = current_user.deliveries.where(:assignment_id => params[:assignment_id]).first
      @assignment = @delivery.assignment
      @course     = @assignment.course
      @comments   = @delivery.comments.order("created_at DESC").page(params[:page]).per(10)
    end

    def new
      @assignment = current_user.assignments.find params[:assignment_id]
      @delivery   = @assignment.deliveries.build
      @course     = @assignment.course
    end

    def create
      @assignment    = current_user.assignments.find params[:assignment_id]
      @delivery      = @assignment.deliveries.build params[:delivery]
      @delivery.user = current_user
       @delivery.raiting = 0
      if @delivery.save
        redirect_to assignment_delivery_path(@assignment), :notice => t('flash.delivery_created')
      else
        @course = @assignment.course
        render :new
      end
    end

    def edit
      @delivery   = current_user.deliveries.where(:assignment_id => params[:assignment_id]).first
      @assignment = @delivery.assignment
      @course     = @assignment.course
    end
    
    def update
      @delivery = current_user.deliveries.where(:assignment_id => params[:assignment_id]).first
      @assignment = @delivery.assignment
      @course     = @assignment.course
    

      if @delivery.update_attributes params[:delivery]
        redirect_to assignment_delivery_path(@delivery.assignment), :notice => t('flash.delivery_updated')
      else
        render :edit
      end
    end
  end
end
