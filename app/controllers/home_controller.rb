class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :index

  def index
    @user = User.new
  end

  def dashboard
    @courses = current_user.teacher? ? current_user.lectures : []
  end
end
