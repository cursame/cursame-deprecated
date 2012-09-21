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
          @user=current_user
      end
      def relate
         @network = current_network  
      end
      

      def password
        # I'm not using if current_user.update_attributes(params[:user])
        # so that the admin can update his password. This would fail because
        # the role of the admin is not allowed by the User model.

        password      = params[:user][:password]
        password_conf = params[:user][:password_confirmation]

        if !password.blank? && password == password_conf
          current_user.password              = password
          current_user.password_confirmation = password
          current_user.save(:validate => false)

          redirect_to root_path, :notice => "Tu contraseña fue cambiada, por favor ingresa con tu nueva contraseña"
        else
          render :show
        end
      end
      
     
end

