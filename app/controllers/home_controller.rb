class HomeController < ApplicationController
  skip_before_filter :authenticate_active_user!, :only => :index
  set_tab :dashboard

  def index
    if current_user && current_user.active?
      case current_user.role
      when 'admin'
        redirect_to admin_path
      when 'supervisor'
        redirect_to supervisor_path
      else
        redirect_to dashboard_url
      end
    else
      @user = User.new
    end
  end

  def dashboard
    # TODO: not specked visible courses scope
    @courses = current_user.visible_courses.where(:network_id => current_network)
  end
end
