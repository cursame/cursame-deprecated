class HomeController < ApplicationController
 
  before_filter :authenticate, :only => [:new_admin]
  skip_before_filter :authenticate_active_user_within_network!, :only => [:index, :terms, :network_cc, :new_admin]  
 #tabs para modificar el menu del header      
    set_tab :dashboard, :only => %(dashboard)
    set_tab :members, :only => %(members)
 
  def index
    if current_user && current_user.active?
      case current_user.role
        when 'admin'
          redirect_to admin_path
        when 'supervisor'
          redirect_to supervisor_dashboard_path
        else
          #redirect_to :dashboard
          redirect_to :principal_wall
      end
    else
      @user = User.new
      @network = current_network
    end
  end

  def dashboard
    @courses       = current_user.visible_courses.where(:network_id => current_network).limit(50)
    @notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(10)
    @users = current_user.favorites.limit(30) if current_user
    @user = current_user
    #@new_users_change_type = NewUsersChangeType.new
    @tasks=current_user.assignments + current_user.surveys
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    # analytics logging
    action = Action.new :user_id => current_user.id, :action => 'dashboard', :user_agent => request.env['HTTP_USER_AGENT'], :country => request.location.country, :city => request.location.city
    action.save!
  end
  
  def dashboard_calendar
      @courses       = current_user.visible_courses.where(:network_id => current_network).limit(4)
      @notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(10)
      @tasks=current_user.assignments + current_user.surveys + current_user.calendar_activities
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @calendar_activity = CalendarActivity.new(params[:calendar_activity])
      @destroy= 
               def destroy
                @calendar_activity = CalendarActivity.find(params[:id])
                @calendar_activity.destroy
               end
  end
  
  def terms
  end
  
  def privacidad
  end
  
  def blog
    @blogs = Blog.all  
  end
  
  def reports
  @user=current_user.id
  end
  
  def help
  end
  
  def members
    @users = current_network.users.search(params[:search])
    # analytics logging
    action = Action.new :user_id => current_user.id, :action => 'members', :user_agent => request.env['HTTP_USER_AGENT'], :country => request.location.country, :city => request.location.city
    action.save!
  end
  
  def new_admin
    @user = User.new
  end
  
  def principal_wall
      @network = current_network    
      @comments = @network.comments.order("created_at DESC").page(params[:page]).per(10)
      @tutoriales = Tutoriale.all  
  end


def network_cc
  @network = Network.new
  @user = User.new
  
end
 def authenticate
  authenticate_or_request_with_http_basic do |username, password|
    username == "logosetvites" && password == "cursameadministratore54321ap09854321"
  end
end
end
