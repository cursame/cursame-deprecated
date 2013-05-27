class AssignmentsController < ApplicationController
  set_tab :assignments

  def index
    @current_assignments = course.assignments.published.where("due_to >= ?", DateTime.now).order("due_to DESC")
    @previous_assignments = course.assignments.published.where("due_to <= ?", DateTime.now).order("due_to DESC")
    @tutoriales = Tutoriale.all
    @banner = Banner.last
    unless current_user.student?
      @unpublished_assignments = course.assignments.created.order("due_to DESC")
    end
  end

  def new
    @assignment = manageable_course.assignments.build
    @assignment.due_to = DateTime.now+1.week
    @tutoriales = Tutoriale.all
    @banner = Banner.last
  end

  def create
    @assignment = manageable_course.assignments.build(params[:assignment])
   
    if @assignment.save
      Innsights.report("Tarea creada", :user => current_user, :group => current_network).run
      redirect_to @assignment, :notice => I18n.t('flash.assignment_created')
    else
      render 'new'
    end
  end

  def edit
    @assignment = manageable_assignment
    @course     = @assignment.course
  end

  def update
    @assignment = manageable_assignment

    if @assignment.update_attributes params[:assignment]
      Innsights.report("Tarea actualizada", :user => current_user, :group => current_network).run
      redirect_to @assignment, :notice => I18n.t('flash.assignment_updated')
    else
      render 'edit'
    end
  end

  def destroy
    manageable_assignment.destroy
    Innsights.report("Tarea eliminada", :user => current_user, :group => current_network).run
    redirect_to course_assignments_path(manageable_assignment.course), :notice => I18n.t('flash.assignment_deleted')
  end

  def show
    @assignment = accessible_assignments.find params[:id]
    @course     = @assignment.course
    @comments   = @assignment.comments.order("created_at DESC").page(params[:page]).per(10)
    @tutoriales = Tutoriale.all
    @banner = Banner.last
  end

  private
  def course
    @course ||= accessible_courses.find params[:course_id]
  end

  def manageable_course
    @course ||= (current_user.supervisor? ? current_network.courses.find(params[:course_id]) : current_user.manageable_courses.find(params[:course_id]))
  end

  def accessible_assignments
    current_user.supervisor? ? current_network.assignments : current_user.assignments
  end

  def manageable_assignment
    @manageagle_assignment ||= current_user.manageable_assignments.find params[:id]
  end
end
