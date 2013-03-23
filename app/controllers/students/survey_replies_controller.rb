class Students::SurveyRepliesController < ApplicationController

  def show
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course
    @reveal_answers = @survey.due_to < Time.now
    @tutoriales = Tutoriale.all
  end

  def new
    @survey = current_user.surveys.published.find params[:survey_id]
    @course = @survey.course
    @survey_reply = current_user.survey_replies.build(:survey => @survey)
    @tutoriales = Tutoriale.all
    @survey.questions.each do |question|
      @survey_reply.survey_answers.build :question => question
    end
  end

  def create
    @survey = current_user.surveys.published.find params[:survey_id]
    @survey_reply = current_user.survey_replies.build(params[:survey_reply])
    @survey_reply.survey = @survey
    if @survey_reply.save
      if @survey_reply.score < 80
         redirect_to survey_reply_path(@survey), :notice => t('flash.survey_failed', :score => @survey_reply.score)
       else
         redirect_to survey_reply_path(@survey), :notice => t('flash.survey_approved', :score => @survey_reply.score)
       end
    else
      @course = @survey.course
      render :new
    end
  end

  def edit
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course
    @tutoriales = Tutoriale.all
  end

  def update
    @survey_reply = current_user.survey_replies.where(:survey_id => params[:survey_id]).first
    @survey = @survey_reply.survey
    @course = @survey_reply.course
    if @survey_reply.update_attributes params[:survey_reply]
      if @survey_reply.score < 80
         redirect_to survey_reply_path(@survey), :notice => t('flash.survey_failed', :score => @survey_reply.score) 
       else
         redirect_to survey_reply_path(@survey), :notice => t('flash.survey_approved', :score => @survey_reply.score)
       end
    else
      render :edit
    end
  end
end
