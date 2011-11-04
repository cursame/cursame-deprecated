class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :index

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
    @courses = current_user.courses
  end
end
