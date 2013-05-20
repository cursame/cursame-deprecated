class MigratedCoursesController < ApplicationController
  
  skip_before_filter :migrated_network, :only => :index
  skip_before_filter :authenticate_active_user_within_network!, :only => :index

  def index
  	@subdomain = current_network.subdomain
  end

end
