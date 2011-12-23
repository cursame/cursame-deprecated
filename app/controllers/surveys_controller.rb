class SurveysController < ApplicationController
  set_tab :surveys

  def index
    @surveys = course.surveys.order("due_to DESC")
  end

  def new
    @survey = manageable_course.surveys.build
  end

  def create
    @survey = manageable_course.surveys.build(params[:survey])
    if @survey.save
      redirect_to @survey, :notice => I18n.t('flash.survey_created')
    else
      render 'new'
    end
  end

  def show
    @survey = accessible_surveys.find params[:id]
    @course = @survey.course
    @survey_reply = current_user.survey_replies.where(:survey_id => @survey).first
  end

  def edit
    @survey = current_user.manageable_surveys.find params[:id]
    @course = @survey.course
  end

  def update
    @survey = current_user.manageable_surveys.find params[:id]
    if @survey.update_attributes params[:survey]
      redirect_to @survey, :notice => I18n.t('flash.survey_updated')
    else
      render 'edit'
    end
  end

  private
  # TODO: fix smell (duplication)
  def course
    @course ||= accessible_courses.find params[:course_id]
  end

  # TODO: fix smell (duplication)
  def manageable_course
    @course ||= current_user.manageable_courses.find params[:course_id]
  end

  def accessible_surveys
    current_user.supervisor? ? current_network.surveys : current_user.surveys
  end
end
