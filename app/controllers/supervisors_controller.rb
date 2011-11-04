class SupervisorsController < ApplicationController
  before_filter :authenticate_supervisor!
  before_filter :require_network

  def show
  end


  def courses
    @courses = current_network.courses
  end


  def teachers
    @teachers = current_network.teachers
  end


  def students
    @students = current_network.students
  end


  def pending_approvals
    @pending = User.unscoped.joins(:networks).where(
      'networks.id' => current_network.id,
      :role => 'teacher',
      :state => 'inactive')
  end


  def accept_user
    @user = User.unscoped.find params[:user_id]

    if @user.networks.include? current_network
      @user.state = 'active'
      @user.save(:validate => false)
    end

    redirect_to pending_approvals_supervisor_path, :notice => t('flash.user_registration_accepted')
  end


  def reject_user
    @user = User.unscoped.find params[:user_id]

    if @user.networks.include? current_network
      @user.destroy
    end

    redirect_to pending_approvals_supervisor_path, :notice => t('flash.user_registration_rejected')
  end
end
