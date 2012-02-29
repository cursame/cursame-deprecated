require 'export_to_csv'

class SupervisorController < ApplicationController
  include ExportToCsv

  before_filter :authenticate_supervisor!
  set_tab :dashboard, :only => %w(dashboard)
  set_tab :teachers, :only => %w(teachers)
  set_tab :students, :only => %w(students)

  def dashboard
    @networks = current_user.networks
    @notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(10)
  end

  def teachers
    teachers = current_network.teachers.order("upper(first_name), upper(last_name) asc")
    @approved = teachers.where(:state => 'active').page(params[:a_page])
    @pending = teachers.where(:state => 'inactive').page(params[:p_page])
    respond_to do |format|
      format.html
      format.csv { export_csv(@approved) }
    end
  end

  def students
    @students = current_network.students.page(params[:page]).order("upper(first_name), upper(last_name) asc")
    respond_to do |format|
      format.html
      format.csv { export_csv(@students) }
    end
  end

  def import_users
    @asset = Asset.new
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
  
  def new_user
    @user = User.new
  end


  protected

  def export_csv(users)
    csv = export_users_to_csv(users)
    user_type = users.first.role.pluralize.capitalize
    filename = Time.now.strftime("%d-%m-%Y") + "_#{user_type}_#{current_network.name}"
    send_data csv,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end

end
