class HomeController < ApplicationController
  skip_before_filter :authenticate_active_user_within_network!, :only => [:index, :terms]
  set_tab :dashboard

  def index
    if current_user && current_user.active?
      case current_user.role
      when 'admin'
        redirect_to admin_path
      when 'supervisor'
        redirect_to supervisor_dashboard_path
      else
        redirect_to dashboard_url
      end
    else
      @user = User.new
      @network = current_network
    end
  end

  def dashboard
    @courses       = current_user.visible_courses.where(:network_id => current_network)
    @notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(10)
  end

  def terms
  end

end
