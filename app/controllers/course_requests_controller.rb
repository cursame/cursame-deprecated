class CourseRequestsController < ApplicationController
  before_filter :authenticate_teacher!, :except => [:create]
  before_filter :load_course, :only => [:create, :index]

  # def join
  def create
    unless current_user.enrollments.where(:course_id => @course).exists?
      current_user.enrollments.create(:course => @course,
                                      :state => 'pending',
                                      :role => current_user.role)
    end
    redirect_to courses_path, :notice => t('flash.course_join_requested')
  end

  def index
    @requests = @course.enrollments.where(:state => 'pending')
  end

  def accept
    request = current_user.enrollment_requests.where(:state => 'pending').find params[:id]
    request.update_attribute(:state, 'accepted')
    redirect_to course_requests_path request.course
  end

  def reject
    request = current_user.enrollment_requests.where(:state => 'pending').find params[:id]
    request.update_attribute(:state, 'rejected')
    redirect_to course_requests_path request.course
  end

  def load_course
    @course = current_network.courses.find params[:course_id]
  end
end
