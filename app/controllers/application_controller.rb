class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

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
end
