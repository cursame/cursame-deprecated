class CoursesController < ApplicationController
  def index
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_network.courses.build params[:course]
    @course.assignations.build(:user => current_user, :admin => true)
    puts current_user.inspect
    puts @course.assignations.inspect

    if @course.save
      redirect_to @course, :notice => t('flash.course_created')
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

end
