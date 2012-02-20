class SupervisorController < ApplicationController
  before_filter :authenticate_supervisor!
  set_tab :dashboard, :only => %w(dashboard)
  set_tab :teachers, :only => %w(teachers)
  set_tab :students, :only => %w(students)

  def dashboard
    @networks = current_user.networks
  end

  def teachers
    teachers = current_network.teachers
    @approved = teachers.where(:state => 'active').page(params[:a_page])
    @pending = teachers.where(:state => 'inactive').page(params[:p_page])
  end

  def students
    @students = current_network.students.page(params[:page])
  end

  def accept_user
    @user = User.unscoped.find params[:user_id]

    if @user.networks.include? current_network
      @user.state = 'active'
      @user.save(:validate => false)
    end

    redirect_to supervisor_teachers_path, :notice => t('flash.user_registration_accepted')
  end

  def reject_user # TODO: not to destroy ---DANGER---
    @user = User.unscoped.find params[:user_id]
    @user.destroy if @user.networks.include? current_network
    redirect_to supervisor_teachers_path, :notice => t('flash.user_registration_rejected')
  end
  
end
