class HomeController < ApplicationController
  skip_before_filter :authenticate_active_user_within_network!, :only => [:index, :terms, :network_cc]  
 #tabs para modificar el menu del header      
    set_tab :dashboard, :only => %(dashboard principal_wall)
    set_tab :principal_wall
  def index
    if current_user && current_user.active?
      case current_user.role
        when 'admin'
          redirect_to admin_path
        when 'supervisor'
          redirect_to supervisor_dashboard_path
        else
        if current_network.variante == "free"
          redirect_to dashboard_url
        else
          redirect_to :principal_wall
        end
      end
    else
      @user = User.new
      @network = current_network
    end
  end

  def dashboard
    @courses       = current_user.visible_courses.where(:network_id => current_network).limit(4)
    @notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(10)
    @users = current_user.favorites.limit(30) if current_user
    @new_users_change_type = NewUsersChangeType.new
    @tasks=current_user.assignments + current_user.surveys
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
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
  end
  def principal_wall
      @tutoriales = Tutoriale.all
      
      @public_comments = current_network.public_comments
      @public_comment = PublicComment.new(params[:public_comment])
      @public_comments_comment = PublicCommentsComment.new(params[:public_comments_comment])
      
  end
end

def network_cc
  @network = Network.new
  @user = User.new
end
