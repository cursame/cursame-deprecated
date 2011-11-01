class CoursesController < ApplicationController
  before_filter :authenticate_teacher!, :only => [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_network.courses.build params[:course]
    @course.assignations.build(:user => current_user, :admin => true)

    if @course.save
      redirect_to @course, :notice => t('flash.course_created')
    else
      render :new
    end
  end

  def edit
    @course = current_user.manageable_lectures.find params[:id]
  end

  def show
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
