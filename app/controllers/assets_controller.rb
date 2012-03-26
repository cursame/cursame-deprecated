class AssetsController < ApplicationController

  before_filter :authenticate_supervisor!, :only => [:create]

  def upload
    asset_file = Asset.new :file => uploaded_file
    as_json = asset_file.as_json(:methods => [:file_cache], :only => [:file_cache]).merge(:file => asset_file.file.to_hash)
    
    render :json => as_json
  end

  def create
    @asset_file = Asset.new(params[:asset])
    @asset_file.owner = current_user
    if valid_role? params[:role] 
      if @asset_file.save 
        Asset.delay.import_csv(@asset_file.id, params[:role], current_network.id)
        redirect_to supervisor_dashboard_path, flash: {success: "Importando usuarios. Recibiras un correo y notificacion al terminar esta tarea."}
      else
        render 'supervisor/import_users'
      end
    else
      redirect_to supervisor_dashboard_path, flash: {error: "Rol de usuarios invalido."}
    end
  end

  private

  def valid_role? role
    role == "teacher" or role == "student"
  end
end
