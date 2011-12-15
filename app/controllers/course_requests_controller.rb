class CourseRequestsController < ApplicationController
  before_filter :authenticate_teacher!, :except => [:create]
  set_tab :request

  def create
    # TODO: requesting again has no acceptance test
    @course = current_network.courses.find params[:course_id]
    request = current_user.enrollments.where(:course_id => @course, :user_id => current_user).first || current_user.enrollments.build(:course => @course)
    request.state = 'pending'
    request.role  = 'student'
    request.save!
    redirect_to courses_path, :notice => t('flash.course_join_requested')
  end

  def accept
    course_request = current_user.enrollment_requests.find params[:id]
    course_request.accept!
    if request.xhr?
      head :ok
    else
      redirect_to members_for_course_path course_request.course
    end
  end

  def reject
    course_request = current_user.enrollment_requests.find params[:id]
    course_request.reject!
    if request.xhr?
      head :ok
    else
      redirect_to members_for_course_path course_request.course
    end
  end
end
