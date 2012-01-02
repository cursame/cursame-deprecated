class Teachers::SurveyRepliesController < ApplicationController
  def index
    @survey  = current_user.manageable_surveys.find params[:survey_id]
    @replies = @survey.survey_replies
    @course  = @survey.course
  end

  def show
    @survey_reply = current_user.manageable_survey_replies.find params[:id]
    @survey = @survey_reply.survey
    @course = @survey_reply.course
    @reveal_answers = true 
    render 'students/survey_replies/show'
  end
end
