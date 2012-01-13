require 'spec_helper'

feature 'Surveys', %q{
  In order to acomplish course
  As a student
  I want answer surveys
} do

  background do
    @network = Factory(:network)
    @student = Factory(:student, :networks => [@network])
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    @course.enrollments.create(:user => @student, :role => 'student', :state => 'accepted')
    @course.enrollments.create(:user => @teacher, :role => 'teacher', :admin => true)
    @survey  = Factory(:published_survey, :course => @course)
    sign_in_with @student, :subdomain => @network.subdomain
  end

  scenario 'viewing a list of surveys' do
    surveys = (1..2).map { Factory(:published_survey, :course => @course) }
    unpublished_survey = Factory(:survey, :course => @course)
    surveys << @survey

    visit course_surveys_url @course, :subdomain => @network.subdomain

    surveys.each do |survey|
      page.should show_survey_preview survey
    end
    page.should_not show_survey_preview unpublished_survey
  end

  scenario 'answering a survey' do
    # add a question that will not be answered
    @survey.questions << Factory(:question)

    visit course_surveys_path @course
    question       = @survey.questions.first
    correct_answer = question.correct_answer

    within('.survey:last') do
      click_link I18n.t('surveys.survey.answer')
    end

    lambda do
      choose correct_answer.text
      click_button 'submit'
    end.should change(SurveyReply, :count).by(1)

    survey_reply = SurveyReply.last
    SurveyReply.should exist_with :user_id => @student.id, :survey_id => @survey.id
    SurveyAnswer.should exist_with :answer_uuid => correct_answer.uuid, 
      :question_id => question.id,
      :survey_reply_id => survey_reply.id

    page.should have_notice t('flash.survey_reply_created')

    Notification.should exist_with :user_id => @teacher.id, :notificator_id => survey_reply.id, :kind => 'teacher_survey_replied'

    page.should show_survey_reply survey_reply
  end

  scenario 'trying to view an unanswered survey' do
    lambda do
      visit survey_path Factory(:survey, :course => @course)
    end.should raise_error ActiveRecord::RecordNotFound
  end

  scenario 'viewing a survey reply' do
    survey_reply = Factory(:survey_reply, :user => @student, :survey => @survey)
    visit survey_reply_path @survey
    page.should show_survey_reply survey_reply
    page.should_not have_content "#{survey_reply.score}%"
  end

  scenario 'viewing a survey reply with score' do
    survey_reply = Factory(:survey_reply, :user => @student, :survey => @survey)
    Timecop.freeze(6.months.from_now) do
      visit survey_reply_path @survey
      page.should show_survey_reply survey_reply
      page.should have_content "#{survey_reply.score}%"
    end
  end

  scenario 'editing a survey reply' do
    question = @survey.questions.first
    survey_reply = Factory(:wrong_survey_reply, :user => @student, :survey => @survey)

    visit survey_reply_path @survey
    click_link t('students.survey_replies.show.edit')
    correct_answer = @survey.questions.first.correct_answer

    lambda do
      choose correct_answer.text
      click_button 'submit'
    end.should_not change(SurveyReply, :count)

    survey_reply = SurveyReply.last
    SurveyReply.should exist_with :user_id => @student.id, :survey_id => @survey.id
    SurveyAnswer.should exist_with :answer_uuid => correct_answer.uuid, 
      :question_id => question.id,
      :survey_reply_id => survey_reply.id

    page.should have_notice t('flash.survey_reply_updated')

    Notification.should exist_with :user_id => @teacher.id, :notificator_id => survey_reply.id, :kind => 'teacher_survey_updated'

    page.should show_survey_reply survey_reply
  end

  scenario 'trying to reply to a survey when it has expired' do
    Timecop.freeze(6.months.from_now) do
      visit survey_path @survey
      page.should_not link_to new_survey_reply_path(@survey)
    end
  end

  scenario 'trying to answer a survey when it has expired' do
    survey_reply = Factory(:survey_reply, :user => @student, :survey => @survey)
    Timecop.freeze(6.months.from_now) do
      visit survey_reply_path @survey
      page.should_not link_to edit_survey_reply_path(survey_reply)
    end
  end

  scenario 'trying to edit answers for a survey when it has expired' do
    Timecop.freeze(6.months.from_now) do
      lambda do
        page.driver.post survey_reply_path(@survey), :survey_reply => {}
      end.should_not change(SurveyReply, :count)
    end
  end
end
