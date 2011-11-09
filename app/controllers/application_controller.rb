class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_active_user!

  private
  def authenticate_teacher!
    current_user && current_user.teacher? or throw(:warden)
  end

  def authenticate_student!
    current_user && current_user.student? or throw(:warden)
  end

  def authenticate_supervisor!
    current_user && current_user.supervisor? or throw(:warden)
  end

  def require_network
    redirect_to root_path unless current_network
  end

  def uploaded_file
    params[:file] ||
    {
      :filename => env['HTTP_X_FILE_NAME'], 
      :type     => env["CONTENT_TYPE"], 
      :tempfile => env['rack.input']  
    }
  end

  def after_sign_in_path_for(resource)
    if resource.role == 'admin'
      admin_path
    elsif resource.role == 'supervisor'
      supervisor_path
    else
      dashboard_url(:subdomain => request.subdomain.blank? ? current_user.networks.first.subdomain : request.subdomain)
    end
  end

  def current_network
    @current_network ||= Network.find_by_subdomain(request.subdomain)
  end

  def authenticate_active_user!
    authenticate_user!
    if current_user && !current_user.active?
      sign_out
      warden.logout
      flash[:error] = t('flash.account_not_active')
      # sign_out
      # Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      redirect_to root_path
    end
  end
end
