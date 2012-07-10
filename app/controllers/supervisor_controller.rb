require 'export_to_csv'

class SupervisorController < ApplicationController
  include ExportToCsv

  before_filter :authenticate_supervisor!
  set_tab :dashboard, :only => %w(dashboard)
  set_tab :teachers, :only => %w(teachers)
  set_tab :students, :only => %w(students)
  set_tab :supervisors, :only => %w(supervisors)
  set_tab :new_user, :only => %w(new_user)
  set_tab :suspended, :only => %w(suspended)
  def dashboard
    @networks = current_user.networks
    @notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(10)
  end

  def teachers
    teachers = current_network.teachers.order("upper(first_name), upper(last_name) asc")
    @teachers_count = teachers.where(:view_status => 'live').where(:state => 'active').count
    @approved = teachers.where(:view_status => 'live').where(:state => 'active').page(params[:a_page]).per(15)
    @pending = teachers.where(:state => 'inactive').page(params[:p_page]).per(15)
    @status = Status.new
    respond_to do |format|
      format.html
      format.csv { export_csv(@approved) }
    end
  end

  def students
    @students = current_network.students.where(:view_status => 'live').order("upper(first_name), upper(last_name) asc").page(params[:page]).per(15)
    @students_count = current_network.students.where(:view_status => 'live').where(:state => 'active').count
    @status = Status.new
    respond_to do |format|
      format.html
      format.csv { export_csv(@students) }
    end
  end
  
  def supervisors
    @supervisors = current_network.supervisors.order("upper(first_name), upper(last_name) asc").page(params[:page]).per(15)
    respond_to do |format|
      format.html
      format.csv { export_csv(@supervisors) }
    end
  end
  def suspended
    @users = current_network.users.where(:view_status => 'fantom').order("upper(first_name), upper(last_name) asc").page(params[:page]).per(10)
    @counter = current_network.users.where(:view_status => 'fantom').count
    @status = Status.new
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
