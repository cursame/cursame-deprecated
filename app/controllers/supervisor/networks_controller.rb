require 'yaml'
class Supervisor::NetworksController < ApplicationController
  before_filter :authenticate_supervisor!
  set_tab :configuration

  def edit
    @network = current_network
  end

  def update
    @network = current_network
    @network.lenguajes=params[:lenguajes]
    @network.save
    if @network.update_attributes params[:network]
      redirect_to edit_supervisor_network_path, :notice => t('flash.network_updated')

    I18n.locale = @network.lenguajes if @network.lenguajes.present?
      def default_url_options(options = {})
      {lenguajes: I18n.locale}
      end
    else
      render :edit
    end
  end

  def upload_logo
    asset_file = Network.new :logo_file => uploaded_file
    render :json => asset_file.as_json(:methods => [:logo_file_cache], :only => [:logo_file, :logo_file_cache])
  end
end
