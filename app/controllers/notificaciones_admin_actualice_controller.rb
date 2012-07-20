class NotificacionesAdminActualiceController < ApplicationController
  
  def new
    @notificaciones_admin_actualouse = NotificacionesAdminActualouse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notificaciones_admin_actualouse }
    end
  end

  # GET /notificaciones_admin_actualice/1/edit
  def edit
    @notificaciones_admin_actualouse = NotificacionesAdminActualouse.find(params[:id])
  end

  # POST /notificaciones_admin_actualice
  # POST /notificaciones_admin_actualice.json
  def create
    @notificaciones_admin_actualouse = NotificacionesAdminActualouse.new(params[:notificaciones_admin_actualouse])

    respond_to do |format|
      if @notificaciones_admin_actualouse.save
        format.html { redirect_to :back, notice: 'Notificaciones admin actualouse was successfully created.' }
        format.json { render json: @notificaciones_admin_actualouse, status: :created, location: @notificaciones_admin_actualouse }
      else
        format.html { render action: "new" }
        format.json { render json: @notificaciones_admin_actualouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notificaciones_admin_actualice/1
  # PUT /notificaciones_admin_actualice/1.json
  def update
    @notificaciones_admin_actualouse = NotificacionesAdminActualouse.find(params[:id])

    respond_to do |format|
      if @notificaciones_admin_actualouse.update_attributes(params[:notificaciones_admin_actualouse])
        format.html { redirect_to @notificaciones_admin_actualouse, notice: 'Notificaciones admin actualouse was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @notificaciones_admin_actualouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notificaciones_admin_actualice/1
  # DELETE /notificaciones_admin_actualice/1.json
  def destroy
    @notificaciones_admin_actualouse = NotificacionesAdminActualouse.find(params[:id])
    @notificaciones_admin_actualouse.destroy

    respond_to do |format|
      format.html { redirect_to notificaciones_admin_actualice_url }
      format.json { head :ok }
    end
  end
end
