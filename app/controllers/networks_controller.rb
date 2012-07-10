class NetworksController < ApplicationController
  skip_before_filter :authenticate_active_user_within_network!, :only => [:network_cc , :create, :update, :instrucciones]
  #bloquea el layout en el network_cc
  #layout 'application', :except => [:network_cc ]
      def network_cc
        @network = Network.new
        @network.supervisors.build
      end
      def instrucciones
        
      end
      
      def create
        @network = Network.new params[:network]
        if @network.save
          redirect_to  :instrucciones_red, :notice => t('Red creada correctamente')
        else
          render :new
        end
      end

      def show
        @network = Network.find params[:id]
      end

      def update
        @network = Network.find params[:id]
        if @network.update_attributes params[:network]
          redirect_to @network.id, :notice => t('flash.network_updated')
        else
          render :edit
        end
      end
      
end

