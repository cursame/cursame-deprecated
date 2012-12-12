class NetworksController < ApplicationController
  skip_before_filter :authenticate_active_user_within_network!, :only => [:network_cc , :create, :update, :instrucciones]
  #bloquea el layout en el network_cc
 # layout 'application', :except => [:network_cc ] 
 # layout 'new_network', :except => [:create, :update, :instrucciones, :principal_wall]
 set_tab :principal_wall
      def network_cc
        @network = Network.new
        @network.supervisors.build
      end
      def instrucciones
        
      end
      
       def create
          @network = Network.new params[:network]
          if @network.save
            redirect_to  :back, :notice => t('Red creada correctamente')
          else
            redirect_to :back, :notice => t('Red creada incorrectamente')
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
      def principal_wall
          @network = current_network    
          @comments = @network.comments.order("created_at DESC").page(params[:page]).per(10)
          @tutoriales = Tutoriale.all         
          @user = current_user
          @new_users_change_type = NewUsersChangeType.new
	  action_entry 'principal_wall'
      end
      def relate
         @network = current_network  
      end
      
     
end

