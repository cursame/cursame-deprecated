class CoursesController < ApplicationController
  before_filter :authenticate_teacher!, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :require_network


  def index
    @courses = current_network.courses
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


  private

  def require_network
    redirect_to root_path unless current_network
  end
end
