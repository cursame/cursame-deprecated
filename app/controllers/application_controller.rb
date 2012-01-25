class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_active_user_within_network!
  helper_method :accessible_courses
  before_filter :current_network_pending_teachers

  protected
  def authenticate_teacher!
    current_user && current_user.teacher? or throw(:warden)
  end

  def authenticate_student!
    current_user && current_user.student? or throw(:warden)
  end

  def authenticate_supervisor!
    current_user && current_user.supervisor? or throw(:warden)
  end

  def uploaded_file
    params[:file] ||
    {
      :filename => env['HTTP_X_FILE_NAME'], 
      :type     => env["CONTENT_TYPE"], 
      :tempfile => env['rack.input']  
    }
  end

  def after_sign_in_path_for resource
    case resource.role
    when 'admin'      then admin_path
    when 'supervisor' then supervisor_dashboard_path
    else 
      dashboard_url(:subdomain => request.subdomain.blank? ? current_user.networks.first.subdomain : request.subdomain)
    end
  end

  def current_network
    @current_network ||= Network.find_by_subdomain(request.subdomain)
  end

  def authenticate_active_user_within_network!
    authenticate_user!
    if current_user && !current_user.active?
      sign_out
      flash[:error] = t('flash.account_not_active')
      redirect_to root_path
    elsif current_network && current_user && current_user.networks.where(:id => current_network.id).count == 0
      sign_out
      flash[:error] = t('flash.wrong_network')
      redirect_to root_path
    end
  end

  def accessible_courses
    current_user.supervisor? ? current_network.courses : current_user.visible_courses
  end
  
  def current_network_pending_teachers
    if current_user and current_user.supervisor?
      @pending_teachers_total = current_network.teachers.where(:state => 'inactive').count
    end
  end
  
end
