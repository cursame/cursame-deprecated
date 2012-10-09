class StatusesController < ApplicationController

  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end


  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save   
         @user = @status.user
         @user.view_status = @status.view_status
         @user.save
        
         if @user.view_status == 'live' && @user.teacher?
           Innsights.report("Maestro aceptado", :user => current_user, :group => current_network).run
         elsif @user.teacher?
           Innsights.report("Maestro suspendido", :user => current_user, :group => current_network).run
         end

         format.html { redirect_to :back, notice: 'El status ha sido agregado correctamente al usuario' }
         format.json { render json: :back , status: :created, location: @status }
      else
        format.html { render action: "new" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.json
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

end
