class HomeController < ApplicationController
  def index
    @user = User.new
  end


  def dashboard
    @courses = current_user.teacher? ? current_user.lectures : nil
  end
end
