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
      @bug_answer = BugAnswer.new
    end
    
    def reports_in_proces
       @send_reports=SendReport.all
       @bug_answer = BugAnswer.new
    end
    
    def reports_resolve
        @send_reports=SendReport.all
        @bug_answer = BugAnswer.new
    end
      
    def reports_finished
        @send_reports=SendReport.all
        @bug_answer = BugAnswer.new
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
    
    def users
      @users = User.order("id").page(params[:id]).per(10)
      @total_users = User.all
    end
    
    def specific_search      
      if params[:search] == nil
        @users = User.search().limit(200);
      else
        @users = User.search(params[:search]).limit(200);
      end      
    end
       
    
    private

    def require_admin
      unless current_user && current_user.role == 'admin'
        redirect_to root_path
      end
    end
    
  end
end
