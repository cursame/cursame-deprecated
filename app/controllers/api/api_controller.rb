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
  
  def assignments
     @course = Course.find params[:id]  
     #render :json => {:assignments => @course.assignments.order("due_to DESC"), :count => @course.assignments.count()}, :callback => params[:callback] 
     render :json => {:assignments => ActiveSupport::JSON.decode(@course.assignments.order("due_to DESC").to_json(:include => [:course])), :count => @course.assignments.count()}, :callback => params[:callback]
          
  end
  
  def discussions
     @course = Course.find params[:id]  
     render :json => {:discussions => @course.discussions.order("created_at DESC"), :count => @course.discussions.count()}, :callback => params[:callback]      
  end
  
  def surveys
     @course = Course.find params[:id]  
     render :json => {:surveys => @course.surveys.order("created_at DESC"), :count => @course.surveys.count()}, :callback => params[:callback]      
  end
  
  def users    
    case params[:type]
      when 'Course'
         @course = Course.find params[:id]       
         @users = @course.students + @course.teachers
      when 'Network'
          @users = current_network.users
      when 'Profile'         
         @users = [@user]
      else
         @users = @course.network.users
    end    
    render :json => {:users => @users.as_json, :count => @users.count()}, :callback => params[:callback]      
  end

  def notifications
    @notifications = @user.notifications.order("created_at DESC");
    @notifications_aux = Array.new
    @notifications.each do |notification|
      case notification.kind
        when 'student_course_enrollment'
          next if notification.notificator == nil
          text = I18n.t('notifications.wants_to_participate_in_course')           
          
          user = notification.notificator.user 
          @course = notification.notificator.course 
        when 'student_assignment_delivery' 
          next           
          #next if notification.notificator == nil          
          text = I18n.t('notifications.has_delived_assignment')
          assignment= notification.notificator.assignment 
          user = notification.notificator.user 
          @course = assignment.course
        when 'teacher_survey_replied'
          next if notification.notificator == nil
          text = I18n.t('notifications.has_answered_the_survey')          
          survey = notification.notificator.survey 
          user = notification.notificator.user 
          @course = survey.course 
          text2 = I18n.t('notifications.for_the_course')
        when 'teacher_survey_updated'
          text = I18n.t('notifications.has_updated_survey_answers')
          survey = notification.notificator.survey
          user = notification.notificator.user
          @course = survey.course
        when 'student_course_rejected'          
          text = I18n.t 'notifications.was_rejected'
        when 'student_course_accepted'
          text = I18n.t 'notifications.you_where_accepted_for_course'
        when 'student_assignment_added'
          next
          text = I18n.t 'notifications.assignment_added'
        when 'student_assignment_updated'
          next
          text = I18n.t 'notifications.assignment_updated'
        when 'student_survey_added'
          text = I18n.t 'notifications.survey_added'          
          #puts notification.notificator
          survey = notification.notificator if notification.notificator
          user = notification.notificator.course.teachers.first if notification.notificator
          @course = survey.course if notification.notificator
        when 'user_comment_on_course'
          text = I18n.t 'notifications.has_posted_a_comment_on_course'
          user = notification.notificator.user if notification.notificator
          @course = notification.notificator.commentable if notification.notificator
        when 'user_comment_on_discussion'
          text = I18n.t 'notifications.has_posted_a_comment_on_discussion'
          user = notification.notificator.user if notification.notificator
          @course = notification.notificator.commentable.course if notification.notificator
        when 'course_discussion_added'
          text = I18n.t 'notifications.discussion_added'
        when 'user_comment_on_comment'      
          text = I18n.t 'notifications.has_posted_a_comment_on_comment'
          notification.notificator = notification.notificator.commentable
          user = notification.notificator.user if notification.notificator
        when 'user_comment_on_user'
          next
          text = I18n.t 'notifications.has_posted_a_comment_on_user'
        else #esta es la notificacion por deafult que hay que checar como esta estructurada
          next
      end      
      image = @course.course_logo_file if @course
      
      notification.text = {
          :text => text,
          :notificator => notification.notificator,
          :image => image,
          :user => user,
          :survey => survey,
          :assignment => assignment,
          :course => @course,
          :courseOwner => @course ? @course.owner : nil,
          :courseMembers => @course ? @course.users.count : nil,
          :courseComments => @course ? @course.comments.count : nil,
          :text2 => text2
      }
       @notifications_aux.push(notification)
    end
    render :json => {:notifications => @notifications_aux.as_json, :count => @notifications_aux.count()}, :callback => params[:callback]    
  end

  def comments
    case params[:type]
      when 'Course'
        @commentable = Course.find params[:id]
      when 'Comment'
        @commentable = Comment.find params[:id]
      when 'Survey'
        @survey = Survey.find params[:id]
        @commentable = @survey.course
      when 'Assignment'
        @commentable = Assignment.find params[:id]
      when 'Discussion'
        @commentable = Discussion.find params[:id]
      when 'User'
        @commentable = User.find params[:id]
      when 'Network'
        @commentable = current_network
      else
        @commentable = Course.find params[:id]
        
    end
     puts '--------------------------------------------------'
      puts @commentable.to_yaml ;
      puts '--------------------------------------------------'
    if params[:type] == 'User'
      @comments = @commentable.profile_comments.order("created_at DESC")#.page(params[:page]).per(params[:limit]);
    else
      @comments = @commentable.comments.order("created_at DESC").page(params[:page]).per(params[:limit]);
    end
    render :json => {:comments => ActiveSupport::JSON.decode(@comments.to_json(:include => [:user, :comments, :like_not_likes])), :count => @comments.count()}, :callback => params[:callback]
  end
  
  def create_comment
    @comment = Comment.new
    @comment.commentable_type = params[:commentable_type]
    @comment.commentable_id = params[:commentable_id]
    @comment.text = params[:text]
    @comment.user = @user
    @comment.save
    render :json => {:success => true}, :callback => params[:callback]        
  end
  
  def create_like
     @like_not_like = LikeNotLike.new
     @like_not_like.user_id = current_user.id
     @like_not_like.comment_id = params[:type]
     @like_not_like.like = params[:like]
     @like_not_like.save
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
