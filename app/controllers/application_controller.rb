class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_network
    Network.find_by_subdomain(request.subdomain)
  end
end
