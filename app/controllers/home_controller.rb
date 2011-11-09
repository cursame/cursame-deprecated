class HomeController < ApplicationController
  skip_before_filter :authenticate_active_user!, :only => :index
  set_tab :dashboard

  def index
    if current_user && current_user.role == 'admin'
      redirect_to admin_path
    elsif current_user && current_user.role == 'supervisor'
      redirect_to supervisor_path
    elsif current_user
      redirect_to dashboard_url
    else
      @user = User.new
    end
  end

  def dashboard
    # TODO: not specked visible courses scope
    @courses = current_user.visible_courses
  end
end
