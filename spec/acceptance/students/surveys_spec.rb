require 'acceptance/acceptance_helper'

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
    @survey  = Factory(:survey, :course => @course)
    sign_in_with @student, :subdomain => @network.subdomain
  end

  scenario 'viewing a list of surveys' do
    surveys = (1..2).map { Factory(:survey, :course => @course) }
    surveys << @survey

    visit course_surveys_url @course, :subdomain => @network.subdomain

    surveys.each do |survey|
      page.should show_survey_preview survey
    end
  end

  scenario 'answering a survey' do
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
end