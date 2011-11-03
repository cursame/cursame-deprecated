class UsersController < ApplicationController
  before_filter :require_network
  before_filter :find_user, :except => [:upload_avatar]
  before_filter :can_edit?, :except => [:show, :upload_avatar]

  def show
    # FIXME: You should only see the profile of a user if you have a course in common
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
    @user = User.find params[:id]
  end

  def can_edit?
    # This can be extended to let teachers (or other administrative type of
    # user) edit other users profiles
    unless current_user == @user
      redirect_to root_path
    end
  end
end
