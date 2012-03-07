module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_filter :require_admin

    def admin
    end

    def statistics
    end

    private

    def require_admin
      unless current_user && current_user.role == 'admin'
        redirect_to root_path
      end
    end
    
  end
end
