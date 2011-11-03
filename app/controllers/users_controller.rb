class UsersController < ApplicationController
  before_filter :require_network
  before_filter :find_user, :except => [:upload_avatar]
  before_filter :can_edit?, :except => [:show, :upload_avatar]

  def show
    # You should only see the profile of a user if you have a course in common
    my_courses = current_user.courses
    his_courses = @user.courses

    # If the intersection of the two sets is not empty then we have at least
    # one course in common.
    if (my_courses & his_courses).empty? && current_user != @user
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => t('flash.user_updated')
    else
      render :edit
    end
  end

  def upload_avatar
    asset_file = User.new :avatar_file => uploaded_file
    render :json => asset_file.as_json(:methods => [:avatar_file_cache], :only => [:avatar_file, :avatar_file_cache])
  end


  private

  def find_user
    @user = current_network.users.find params[:id]
  end

  def can_edit?
    # This can be extended to let teachers (or other administrative type of
    # user) edit other users profiles
    unless current_user == @user
      redirect_to root_path
    end
  end
end
