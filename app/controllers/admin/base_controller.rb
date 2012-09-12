module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_filter :require_admin
 
    def admin
    end

    def statistics
    end

    def reports
      @send_reports=SendReport.all
    end
    
    def tutorials
      @tutoriales = Tutoriale.all
      @tutoriale = Tutoriale.new
    end
    def notification
      @notificaciones_admin_actualice = NotificacionesAdminActualouse.all
      @notificaciones_admin_actualice_last = NotificacionesAdminActualouse.last !
      @notificaciones_admin_actualouse = NotificacionesAdminActualouse.new
    end
    def publicity
      @banners = Banner.all
      @banner = Banner.new
    end
    private

    def require_admin
      unless current_user && current_user.role == 'admin'
        redirect_to root_path
      end
    end
    
  end
end
