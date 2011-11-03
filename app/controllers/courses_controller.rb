class CoursesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :require_network

  def index
    @courses = current_network.courses
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_network.courses.build params[:course]
    @course.enrollments.build(:user => current_user, :admin => true, :role => 'teacher')

    if @course.save
      redirect_to @course, :notice => t('flash.course_created')
    else
      raise @course.errors.inspect
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
    @course = current_network.courses.find(params[:id]) 
  end

  def members
    @course = current_network.courses.find params[:id]
  end

  def upload_asset
    asset_file = CourseAsset.new :file => uploaded_file
    render :json => asset_file.as_json(:methods => [:file_cache], :only => [:file, :file_cache])
  end

  def upload_logo
    asset_file = Course.new :logo_file => uploaded_file
    render :json => asset_file.as_json(:methods => [:logo_file_cache], :only => [:logo_file, :logo_file_cache])
  end
end
