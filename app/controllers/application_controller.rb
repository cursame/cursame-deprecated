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
end
