class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def current_network
    Network.find_by_subdomain(request.subdomain)
  end

  def authenticate_teacher!
    current_user && current_user.teacher? or throw(:warden)
  end

  def authenticate_student!
    current_user && current_user.student? or throw(:warden)
  end


  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      dashboard_url(:subdomain => request.subdomain || resource.networks.first.subdomain)
    else
      super
    end
  end
end
