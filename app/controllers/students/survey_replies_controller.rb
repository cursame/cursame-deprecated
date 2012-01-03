class Students::SurveyRepliesController < ApplicationController
  def show
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course
  end

  def new
    @survey = current_user.surveys.find params[:survey_id]
    @course = @survey.course
    @survey_reply = current_user.survey_replies.build(:survey => @survey)
    @survey.questions.each do |question|
      @survey_reply.survey_answers.build :question => question
    end
  end

  def create
    @survey = current_user.surveys.find params[:survey_id]
    @survey_reply = current_user.survey_replies.build(params[:survey_reply])
    @survey_reply.survey = @survey

    if @survey_reply.save
      redirect_to survey_reply_path(@survey), :notice => t('flash.survey_reply_created')
    else
      @course = @survey.course
      render :new
    end
  end

  def edit
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course
  end

  def update
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course

    if @survey_reply.update_attributes params[:survey_reply]
      redirect_to survey_reply_path(@survey), :notice => t('flash.survey_reply_updated')
    else
      render :edit
    end
  end
end
