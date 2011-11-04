class AssignmentsController < ApplicationController
  before_filter :manageable_course, :only => [:new, :create]

  def index
    @course      = current_user.courses.find params[:course_id]
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
    @assignment = manageable_assignment
  end

  def update
    @assignment = manageable_assignment

    if @assignment.update_attributes params[:assignment]
      redirect_to @assignment, :notice => I18n.t('flash.assignment_updated')
    else
      render 'edit'
    end
  end

  def destroy
    manageable_assignment.destroy
    redirect_to course_assignments_path(manageable_assignment.course), :notice => I18n.t('flash.assignment_deleted')
  end

  def show
    @assignment = current_user.assignments.find params[:id]
  end

  private
  def manageable_course
    authenticate_teacher!
    @course ||= current_user.manageable_courses.find params[:course_id]
  end

  def manageable_assignment
    @manageagle_assignment ||= current_user.manageable_assignments.find params[:id]
  end
end
