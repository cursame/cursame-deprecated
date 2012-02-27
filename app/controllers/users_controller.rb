class UsersController < ApplicationController
  set_tab :profile, :only => %w(show)
  set_tab :wall,    :only => %w(wall)

  def show
    find_user
  end

  def edit
    find_user and check_edit_permissions!
  end

  def update
    find_user and check_edit_permissions!
    if @user.update_attributes(params[:user])
      redirect_after_update
    else
      render :edit
    end
  end

  def wall
    find_user
    @comments = @user.profile_comments.order("created_at DESC").page(params[:page]).per(10)
  end

  def upload_avatar
    asset_file = User.new :avatar_file => uploaded_file
    render :json => asset_file.as_json(:methods => [:avatar_file_cache], :only => [:avatar_file, :avatar_file_cache])
  end

  private
  def find_user
    @user ||= current_network.users.find params[:id]
  end

  def check_edit_permissions!
    raise ActiveRecord::RecordNotFound unless current_user == @user or current_user.supervisor?
    true
  end
  
  def redirect_after_update
    if @user != current_user
      redirect_to send("supervisor_#{@user.role}s_path"), :notice => t('flash.user_updated') 
    else
      redirect_to @user, :notice => t('flash.user_updated')
    end
  end
end
