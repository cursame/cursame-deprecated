class Supervisor::NetworksController < ApplicationController
  before_filter :authenticate_supervisor!

  def edit
    @network = current_network
  end

  def update
    @network = current_network
    if @network.update_attributes params[:network]
      redirect_to supervisor_dashboard_path, :notice => t('flash.network_updated')
    else
      render :edit
    end
  end
end
