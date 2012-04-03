class SurveysController < ApplicationController
  set_tab :surveys

  def index
    @current_surveys = course.surveys.published.where("due_to >= ?", DateTime.now).order("due_to DESC")
    @previous_surveys = course.surveys.published.where("due_to <= ?", DateTime.now).order("due_to DESC")
    unless current_user.role_for_course(course) == "student"
      @unpublished_surveys = course.surveys.unpublished.order("due_to DESC")
    end
  end

  def new
    @survey = manageable_course.surveys.build
  end

  def create
    @survey = manageable_course.surveys.build(params[:survey])
    if @survey.save
      flash[:notice] = I18n.t('flash.survey_created')
      redirect_to @survey
    else
      render 'new'
    end
  end

  def show
    @survey = accessible_surveys.find params[:id]
    @course = @survey.course
    if current_user.role_for_course(@course) != 'teacher' && !@survey.published?
      raise ActiveRecord::RecordNotFound
    end
    @survey_reply = current_user.survey_replies.where(:survey_id => @survey).first
  end

  def edit
    @survey = current_user.manageable_surveys.find params[:id]
    if @survey.published?
      redirect_to survey_path @survey 
    else
      @course = @survey.course
    end
  end

  def update
    @survey = current_user.manageable_surveys.find params[:id]
    if @survey.update_attributes params[:survey]
      flash[:notice] = I18n.t('flash.survey_updated')
      redirect_to @survey
    else
      @course = @survey.course
      render 'edit'
    end
  end

  def destroy
    survey = current_user.manageable_surveys.find(params[:id])
    survey.destroy
    redirect_to course_surveys_path(survey.course), :notice => I18n.t('flash.survey_deleted')
  end

  def publish
    current_user.manageable_surveys.find(params[:id]).publish!
    head :ok
  end

  private
  # TODO: fix smell (duplication)
  def course
    @course ||= accessible_courses.find params[:course_id]
  end

  # TODO: fix smell (duplication)
  def manageable_course
    @course ||= (current_user.supervisor? ? current_network.courses.find(params[:course_id]) : current_user.manageable_courses.find(params[:course_id]))
  end

  def accessible_surveys
    surveys = current_user.supervisor? ? current_network.surveys : current_user.surveys
  end
end
