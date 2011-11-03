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

  def uploaded_file
    { 
      :filename => env['HTTP_X_FILE_NAME'], 
      :type     => env["CONTENT_TYPE"], 
      :tempfile => env['rack.input']  
    } 
  end

  def after_sign_in_path_for(resource)
    dashboard_url(:subdomain => request.subdomain.blank? ? current_user.networks.first.subdomain : request.subdomain)
  end

  def current_network
    @current_network ||= Network.find_by_subdomain(request.subdomain)
  end
end
