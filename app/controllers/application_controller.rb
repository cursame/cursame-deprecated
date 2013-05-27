class ApplicationController < ActionController::Base

  # errores
  # Se declaran los errores personalizados
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from Timeout::Error, with: :render_503
  end

  private
  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
  def render_503(exception)
    @time_out=exception
    respond_to do |format|
      format.html { render template: 'errors/error_503', layout: 'layouts/application', status: 503 }
      format.all { render nothing: true, status: 503}
    end
  end
  #/errores
  
  protect_from_forgery
  before_filter :authenticate_active_user_within_network!
  before_filter :redirect_network
  before_filter :migrated_network
  helper_method :accessible_courses
  before_filter :current_network_pending_teachers
  after_filter :current_languaje
  helper_method :current_network
  helper_method :mobile?
  helper_method :web_browsers_cases
  helper_method :browser_active
  helper_method :browser_version
  protected

  def migrated_network
    # agregar los subdominios a los que se les mostrara el aviso de migración
    migrated_courses = []
    migrated_courses.each do |course|
      if course[:subdomain] == current_network.subdomain
        redirect_to "/migrated_courses/index/", :subdomain => current_network.subdomain
      end
    end
  end

  def redirect_network
    # agregar las redes y el dominio al que se redireccionaran
    migrated_networks = [{:subdomain => 'utez', :domain => 'cursalab.com'}]
    migrated_networks.each do |network|
      if network[:subdomain] == current_network.subdomain
        # TODO crear redirect_to dinamico
        redirect_to "http://utez.cursalab.com/"
        #redirect_to "#{current_network.subdomain}.#{network[:domain]}"
      end
    end
  end

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
    when 'admin'      then admin_path(:subdomain => nil)
    when 'supervisor' then supervisor_dashboard_path(:subdomain => (request.subdomain.blank? ? current_user.networks.first.subdomain.downcase : request.subdomain.downcase))
    else 
      dashboard_url(:subdomain => (request.subdomain.blank? ? current_user.networks.first.subdomain.downcase : request.subdomain.downcase))
    end
  end

  def current_network
    @current_network ||= Network.find_by_subdomain(filter_subdomain(request.subdomain.downcase))
  end
  
  def current_languaje
    if current_network
      I18n.locale = current_network.lenguajes
        def default_url_options(options = {})
          {lenguajes: I18n.locale}
        end       
    end  
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
    begin
      @pending_teachers_total = current_network.teachers.where(:state => 'inactive').count if current_user and current_user.supervisor?
    rescue
      @pending_teachers_total = 0
    end
  end
  
  private
  
  def filter_subdomain(subdomain)
    if subdomain.match(/\Awww\..+/)
      return subdomain[4..-1]
    else
      return subdomain
    end
  end
  def chat
  @chat=current_user.chat  
  end
  def mobile?
   # request.user_agent =~ /Mobile|webOS/ 
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod|Android)/]
  end
  
  def web_browsers_cases
    @comparation = browser_active+browser_version    
  end
  
  def browser_active
    @data_integrate = request.env['HTTP_USER_AGENT']
    @user_agent = UserAgent.parse(@data_integrate)
    @browser = @user_agent.browser    
  end

  def browser_version
    @data_integrate = request.env['HTTP_USER_AGENT']
    @user_agent = UserAgent.parse(@data_integrate)
    @browser = @user_agent.version
  end
  
  def computer_platform
    @data_integrate = request.env['HTTP_USER_AGENT']
    @user_agent = UserAgent.parse(@data_integrate)
    @computer_plataform = @user_agent.platform
  end
      
end
