class AssetsController < ApplicationController
  def upload
    asset_file = Asset.new :file => uploaded_file
    as_json = asset_file.as_json(:methods => [:file_cache], :only => [:file_cache]).merge(:file => asset_file.file.to_hash)
    
    render :json => as_json
  end

  def create
    @asset_file = Asset.new(params[:asset])
    if @asset_file.save
      Asset.delay.import_csv(@asset_file.id, params[:role], current_network.id)
      redirect_to supervisor_dashboard_path, flash: {success: "Importando usuarios. Espera a recibir la notificacion."}
    else
      render 'supervisor/import_users'
    end
  end
end
