class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :index

  def index
    if current_user
      redirect_to dashboard_url
    else
      @user = User.new
    end
  end

  def dashboard
    @courses = current_user.teacher? ? current_user.lectures : []
  end
end
