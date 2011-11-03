class AssignmentsController < ApplicationController
  before_filter :load_course, :only => [:new, :create]

  def index
  end

  def new
    @assignment = @course.assignments.build
  end

  def create
    @assignment = @course.assignments.build params[:assignment]

    if @assignment.save
      redirect_to @assignment
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  private
  def load_course
    @course = current_network.courses.find params[:course_id]
  end
end
