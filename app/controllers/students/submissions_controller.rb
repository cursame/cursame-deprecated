module Students
  class SubmissionsController < ApplicationController
    def show
    end

    def new
      @survey = current_user.surveys.find params[:survey_id]
      @course = @survey.course

      @submitted_survey = SubmittedSurvey.new(:survey => @survey, :user => current_user)

      @survey.questions.each do |q|
        @submitted_survey.submitted_questions.build(:question => q)
      end
    end

    def create
      @survey = current_user.surveys.find params[:survey_id]
      @submitted_survey = @survey.submitted_surveys.build params[:submitted_survey]
      @submitted_survey.user = current_user

      if @submitted_survey.save
        redirect_to survey_path(@survey), :notice => t('flash.submitted_survey_updated')
      else
        @course = @survey.course
        render :new
      end
    end

    def edit
    end

    def update
    end
  end
end
