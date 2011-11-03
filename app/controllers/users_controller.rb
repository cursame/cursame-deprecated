class UsersController < ApplicationController
  before_filter :require_network

  def index
  end

  def show
    # FIXME: You should only see the profile of a user if you have a course in common
    @user = User.find params[:id]
  end
end
