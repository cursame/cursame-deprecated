require 'acceptance/acceptance_helper'

feature 'Manage surveys', %q{
  In order to evaluate my students
  As a teacher
  I want generate, view and evaluate surveys
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher')
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'viewing a list of surveys' do
    surveys = (1..3).map { Factory(:survey, :course => @course) }
    visit course_surveys_url @course, :subdomain => @network.subdomain

    surveys.each do |survey|
      page.should show_survey_preview survey
    end
  end

  scenario 'creating a survey', :js => true do
    student = Factory(:student)
    @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')

    visit course_surveys_url(@course, :subdomain => @network.subdomain)
    click_link t('surveys.index.new_survey')

    fill_in 'survey[name]',        :with => 'First survey'
    fill_in 'survey[description]', :with => 'This is a test survey'
    fill_in 'survey[value]',       :with => 9
    fill_in 'survey[period]',      :with => 1

    # TODO: we need a select_date helper
    select '2011',    :from => 'survey[due_to(1i)]'
    select 'enero',   :from => 'survey[due_to(2i)]'
    select '20',      :from => 'survey[due_to(3i)]'
    select '8',       :from => 'survey[due_to(4i)]'
    select '30',      :from => 'survey[due_to(5i)]'


    add_question_with_answers 'A, B or C?'
    add_question_with_answers 'A, B or C?'

    lambda do
      click_button 'submit'
    end.should change(Survey, :count).by(1)

    expected_attrs = {
      :name => 'First survey', 
      :description => ActiveRecord::HTMLSanitization.sanitize('This is a test survey'),
      :value => 9, 
      :period => 1,
      :course_id => @course
    }

    Survey.should exist_with expected_attrs

    survey = Survey.last
    survey.should have(2).questions

    survey.questions.each do |question|
      question.reload
      question.text.should == 'A, B or C?'
      question.should have(4).answers
      question.answer_uuid.should === question.answers.last.uuid
    end

    page.should show_survey_full_preview survey
    page.should have_notice t('flash.survey_created')

    Notification.should exist_with :user_id => student, :notificator_id => survey, :kind => 'student_survey_added'
  end

  scenario 'editing an existing survey', :js => true do
    student = Factory(:student)
    @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')

    survey = Factory(:survey, :course => @course)
    visit survey_url(survey, :subdomain => @network.subdomain)
    click_link t('surveys.show.edit_survey')
    
    sleep 5
    page.should have_checked_field '3' # last question is selected as correct
    
    fill_in 'survey[name]', :with => 'Edited survey'

    lambda do
      click_button 'submit'
    end.should_not change(Survey, :count)

    survey.should have(1).question
    Survey.should exist_with :name => 'Edited survey'
    page.should have_notice t('flash.survey_updated')

    Notification.should exist_with :user_id => student, :notificator_id => survey, :kind => 'student_survey_updated'
  end

  scenario 'viewing the detail of an survey' do
    survey = Factory(:survey, :course => @course)
    visit course_surveys_path @course

    within('.survey:last') do
      click_link survey.name
    end
    page.should show_survey_full_preview survey
  end


  scenario 'removing an existing survey' do
    survey = Factory(:survey, :course => @course)
    visit survey_url(survey, :subdomain => @network.subdomain)

    lambda do
      click_link 'delete'
    end.should change(Survey, :count).by(-1)

    page.should have_notice t('flash.survey_deleted')
    page.current_url.should match course_surveys_path(@course)
  end
end
