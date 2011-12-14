class SupervisorController < ApplicationController
  before_filter :authenticate_supervisor!
  set_tab :dashboard, :only => %w(dashboard)
  set_tab :teachers, :only => %w(teachers)
  set_tab :students, :only => %w(students)
  set_tab :pending_approvals, :only => %w(pending_approvals)

  def dashboard
    @networks = current_user.networks
  end

  def teachers
    @teachers = current_network.teachers
  end

  def students
    @students = current_network.students
  end

  def pending_approvals
    @pending = User.joins(:networks).where(
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

    redirect_to supervisor_pending_approvals_path, :notice => t('flash.user_registration_accepted')
  end

  def reject_user # TODO: not to destroy ---DANGER---
    @user = User.unscoped.find params[:user_id]
    @user.destroy if @user.networks.include? current_network
    redirect_to supervisor_pending_approvals_path, :notice => t('flash.user_registration_rejected')
  end
end
