class ErrorsController < ApplicationController
skip_before_filter :authenticate_active_user_within_network!, :only => [:browser_error, :browser_explain, :error_500]
layout 'application', :except => [:browser_error ]
layout 'browser_select', :except => [:error_404, :error_500, :error_503 ]
  def error_404
    @not_found_path = params[:not_found]
  end

  def error_500
  end
  
  def error_503
  end
  
  def browser_error
  
  end
  
  def browser_explain
  end

end
