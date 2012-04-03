class Api::ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_active_user_within_network!
  before_filter :authorize 
  
  respond_to :json
  def course_requests
    course_request = current_user.enrollment_requests.find params[:id]

    if params[:accept] == true
      course_request.accept!
    else
      course_request.reject!
    end

    respond_to do |format|
      format.json { render :json => {:success => {:id => params[:id], :accept => params[:accept]}} }
    end
  end

  def courses
    @courses = @user.visible_courses.where(:network_id => current_network)
    respond_to do |format|
      format.json { render :json => {:courses => @courses.as_json, :count => @courses.count()} }
    end
  end  

  def notifications
    @notifications = @user.notifications.order("created_at DESC");

    @notifications.each do |notification|
      case notification.kind
        when 'student_course_enrollment'
          text = I18n.t('notifications.wants_to_participate_in_course')
          image = notification.notificator.user.avatar_file.xxsmall.url
          user = notification.notificator.user
          course = notification.notificator.course
        when 'student_assignment_delivery'
          text = I18n.t('notifications.has_delived_assignment')
          image = notification.notificator.user.avatar_file.xxsmall.url
          assignment= notification.notificator.assignment
          user = notification.notificator.user
        when 'teacher_survey_replied'
          text = I18n.t('notifications.has_answered_the_survey')
          survey = notification.notificator.survey
          course = notification.notificator.course
          image = notification.notificator.user.avatar_file.xxsmall.url
          user = notification.notificator.user
          text2 = I18n.t('notifications.for_the_course')
        when 'teacher_survey_updated'
          text = I18n.t('notifications.has_updated_survey_answers')
          survey = notification.notificator.survey
          course = notification.notificator.course
          image = notification.notificator.user.avatar_file.xxsmall.url
          user = notification.notificator.user
        when 'student_course_rejected'
          text = I18n.t 'notifications.was_rejected'
          course = notification.notificator.course
        when 'student_course_accepted'
          text = I18n.t 'notifications.you_where_accepted_for_course'
          course = notification.notificator.course
        when 'student_assignment_added'
          text = I18n.t 'notifications.assignment_added'
          course = notification.notificator.course
        when 'student_assignment_updated'
          text = I18n.t 'notifications.assignment_updated'
          course = notification.notificator.course
        when 'student_survey_added'
          text = I18n.t 'notifications.survey_added'
          course = notification.notificator.course
      end
      notification.text = {
          :text => text,
          :notificator => notification.notificator,
          :image => image,
          :user => user,
          :survey => survey,
          :assignment => assignment,
          :course => course,
          :text2 => text2
      }
    end
    render :json => {:notifications => @notifications.as_json, :count => @notifications.count()}, :callback => params[:callback]    
  end

  def comments
    @course = Course.find params[:id]
    @comments = @course.comments
    render :json => {:comments => ActiveSupport::JSON.decode(@comments.to_json(:include => [:user, :comments])), :count => @comments.count()}, :callback => params[:callback]

  end
  
  private 
  def authorize
    @user=User.find_by_authentication_token(params[:auth_token])
    if @user.nil?
       logger.info("Token not found.")
       render :status => 200, :json => {:message => "Invalid token", :success => false}        
    end
  end
end
