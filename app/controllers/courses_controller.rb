class CoursesController < ApplicationController
  set_tab :course,  :only => %w(index show new create edit update)
  set_tab :courses, :only => %w(index)
  set_tab :wall,    :only => %w(wall)
  set_tab :members, :only => %w(members)
  set_tab :calification, :only => %w(calification)
  def index
    @courses = current_network.courses
    
  end

  def new
    @course = Course.new
    @courses = current_user.courses
  end

  def create    
    if params[:clone]
      old_course = current_user.manageable_courses.find(params[:id])
      @course = old_course.dup
      @course.assignments = old_course.assignments
      @course.surveys = old_course.surveys
      @course.enrollments = []
      @course.pending_students = []
      @course.students = []
      @course.pending_teachers = [] 
      @course.users = []
      @course.discussions = []
      @course.comments = []
      @course.chats = []
    else
      @course = current_network.courses.build params[:course]      
    end
    
    @course.enrollments.build(:user => current_user, :admin => true, :role => 'teacher', :state => 'accepted')
    
    if @course.save
      if params[:clone]
        redirect_to edit_course_path(@course)
      else
        redirect_to @course, :notice => t('flash.course_created')
      end
    else
      render :new
    end
  end

  def edit
    @course = current_user.manageable_courses.find params[:id]
  end

  def update
    @course = current_user.manageable_courses.find params[:id]
    if @course.update_attributes params[:course]
      redirect_to @course, :notice => t('flash.course_updated')
    else
      render :new
    end
  end
  
  def show
    @course = accessible_course 

  end
  def calification
    @course = accessible_course
    @molto_course = @course.assignments
    @bella_survey = @course.surveys
  end
  
  def members
    @course = accessible_course
    if current_user.manageable_courses.include? @course
      @pending_students = @course.pending_students
      @pending_teachers = @course.pending_teachers
    end
    @students = @course.students
    @teachers = @course.teachers
  end

  def wall
    @course   = accessible_course
    @comments = @course.comments.order("created_at DESC").page(params[:page]).per(10)    
    respond_to do |format|
        format.js
        format.html # index.html.erb
    end
  end

  def upload_logo
   course = Course.new :course_logo_file => uploaded_file
  render :json => course.as_json(:methods => [:course_logo_file_cache], :only => [:course_logo_file, :course_logo_file_cache])
  end
  
  def destroy
    course = Course.find(params[:id])
    if course.can_be_destroyed_by? current_user
      course.destroy
      flash[:notice] = t('flash.course_destroyed')
    end
    redirect_to courses_path
  end
  
  protected
  def accessible_course
    @accessible_course ||= accessible_courses.find params[:id]
  end
  
end
