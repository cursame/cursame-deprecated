class CoursesController < ApplicationController
  before_filter :require_network
  set_tab :course, :only => %w(index show new create edit update)
  set_tab :wall, :only => %w(wall)
  set_tab :members, :only => %w(members)

  def index
    @courses = current_network.courses
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_network.courses.build params[:course]
    @course.enrollments.build(:user => current_user, :admin => true, :role => 'teacher', :state => 'accepted')

    if @course.save
      redirect_to @course, :notice => t('flash.course_created')
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

  def members
    @course = accessible_course
  end

  def wall
    @course = accessible_course
  end

  def upload_logo
    course = Course.new :logo_file => uploaded_file
    render :json => course.as_json(:methods => [:logo_file_cache], :only => [:logo_file, :logo_file_cache])
  end

  private
  def accessible_course
    @accessible_course ||= accessible_courses.find params[:id]
  end

  def accessible_courses
    current_user.supervisor? ? current_network.courses : current_user.visible_courses.where(:network_id => current_network)
  end
end
