class AssignmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :manageable_course, :except => [:index, :show]

  def index
    @course      = current_user.courses.find params[:course_id]
    puts @course.assignments.inspect
    @assignments = @course.assignments
  end

  def new
    @assignment = @course.assignments.build
  end

  def create
    @assignment = @course.assignments.build params[:assignment]
    if @assignment.save
      redirect_to @assignment, :notice => I18n.t('flash.assignment_created')
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @assignment = current_user.assignments.find params[:id]
  end

  private
  def manageable_course
    authenticate_teacher!
    @course ||= current_user.manageable_courses.find params[:course_id]
  end
end
