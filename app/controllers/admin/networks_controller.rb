module Admin
  class NetworksController < BaseController
    def index
      @networks = Network.order('name ASC')
    end

    def new
      @network = Network.new
      @network.supervisors.build
    end

    def create
      @network = Network.new params[:network]
      debugger
      if @network.save
        redirect_to [:admin, @network], :notice => t('flash.network_created')
      else
        render :new
      end
    end

    def show
      @network = Network.find params[:id]
    end

    def edit
      @network = Network.find params[:id]
    end

    def update
      @network = Network.find params[:id]
      if @network.update_attributes params[:network]
        redirect_to [:admin, @network], :notice => t('flash.network_updated')
      else
        render :edit
      end
    end
  end
end
