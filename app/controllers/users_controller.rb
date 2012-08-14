class UsersController < ApplicationController
  set_tab :profile, :only => %w(show)
  set_tab :wall,    :only => %w(wall)

  before_filter :authenticate_supervisor!, :only => [:create]
  def show
    find_user
    @favorite = Favorite.new
    @friend_crocodile = current_user.id 
    @friend_salamander = find_user
    @tutoriales = Tutoriale.all
  end

  def edit
    find_user and check_edit_permissions!
  end

  def create
    @user = User.new params[:user]
    password = Devise.friendly_token[0,20]
    build_user(password)
    if @user.save
      UserMailer.delay.new_user_by_supervisor(@user, current_network, password)
      redirect_to @user, :notice => I18n.t('flash.user_created')
    else
      render 'supervisor/new_user'
    end
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
     @favorite = Favorite.new
     @friend_crocodile = current_user.id 
     @friend_salamander = find_user
     @tutoriales = Tutoriale.all
  end

  def upload_avatar
    asset_file = User.new :avatar_file => uploaded_file
    render :json => asset_file.as_json(:methods => [:avatar_file_cache], :only => [:avatar_file, :avatar_file_cache])
  end
  
  private
  def find_user
    @user ||= current_network.users.find params[:id]
  end

  def build_user(password)
    @user.password = password
    @user.confirmed_at = DateTime.now
    @user.networks = [current_network]
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
