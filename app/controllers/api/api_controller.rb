class Api::ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_active_user_within_network!
  before_filter :authorize 
  
  respond_to :json
  def course_requests
    course_request = @user.enrollment_requests.find params[:id]
    
    if params[:accept] == true
      course_request.accept!
    else
      course_request.reject!
    end    
    render :json => {:success => true}, :callback => params[:callback]    
  end

  def courses
    @courses = @user.visible_courses.where(:network_id => current_network)    
    render :json => {:courses => @courses.as_json, :count => @courses.count()}, :callback => params[:callback]      
  end  

  def notifications
    @notifications = @user.notifications.order("created_at DESC");

    @notifications.each do |notification|
      case notification.kind
        when 'student_course_enrollment'
          text = I18n.t('notifications.wants_to_participate_in_course')
          image = notification.notificator.user.avatar_file.xxsmall.url
          user = notification.notificator.user
        when 'student_assignment_delivery'
          text = I18n.t('notifications.has_delived_assignment')
          image = notification.notificator.user.avatar_file.xxsmall.url
          assignment= notification.notificator.assignment
          user = notification.notificator.user
        when 'teacher_survey_replied'
          text = I18n.t('notifications.has_answered_the_survey')
          survey = notification.notificator.survey
          image = notification.notificator.user.avatar_file.xxsmall.url
          user = notification.notificator.user
          text2 = I18n.t('notifications.for_the_course')
        when 'teacher_survey_updated'
          text = I18n.t('notifications.has_updated_survey_answers')
          survey = notification.notificator.survey
          image = notification.notificator.user.avatar_file.xxsmall.url
          user = notification.notificator.user
        when 'student_course_rejected'
          text = I18n.t 'notifications.was_rejected'
        when 'student_course_accepted'
          text = I18n.t 'notifications.you_where_accepted_for_course'
        when 'student_assignment_added'
          text = I18n.t 'notifications.assignment_added'
        when 'student_assignment_updated'
          text = I18n.t 'notifications.assignment_updated'
        when 'student_survey_added'
          text = I18n.t 'notifications.survey_added'
      end
      
      notification.text = {
          :text => text,
          :notificator => notification.notificator,
          :image => image,
          :user => user,
          :survey => survey,
          :assignment => assignment,
          :course => notification.notificator.course,
          :courseOwner => notification.notificator.course.owner,
          :courseMembers => notification.notificator.course.users.count,
          :courseComments => notification.notificator.course.comments.count,
          :text2 => text2
      }
    end
    render :json => {:notifications => @notifications.as_json, :count => @notifications.count()}, :callback => params[:callback]    
  end

  def comments
    case params[:type]
      when 'Course'
        @commentable = Course.find params[:id]
      when 'Comment'
        @commentable = Comment.find params[:id]
      else
        @commentable = Course.find params[:id]
    end
    @comments = @commentable.comments
    render :json => {:comments => ActiveSupport::JSON.decode(@comments.to_json(:include => [:user, :comments])), :count => @comments.count()}, :callback => params[:callback]
  end
  
  def create_comment
    @comment = Comment.new
    @comment.commentable_type= params[:commentable_type]
    @comment.commentable_id = params[:commentable_id]
    @comment.text = params[:text]
    @comment.user = @user
    @comment.save
    render :json => {:success => true}, :callback => params[:callback]    
    
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
