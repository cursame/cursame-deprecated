require 'spec_helper'

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

  scenario 'creating a survey without publishing', :js => true do
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
      click_button t('formtastic.actions.create')
    end.should change(Survey, :count).by(1)

    expected_attrs = {
      :name => 'First survey', 
      :description => ActiveRecord::HTMLSanitization.sanitize('This is a test survey'),
      :value => 9, 
      :period => 1,
      :course_id => @course,
      :state => :unpublished
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

    Notification.should_not exist_with :user_id => student, :notificator_id => survey, :kind => 'student_survey_added'
  end

  scenario 'creating a survey with publishing', :js => true do
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

    lambda do
      click_button t('formtastic.actions.create_and_publish')
    end.should change(Survey, :count).by(1)

    expected_attrs = {
      :name => 'First survey', 
      :description => ActiveRecord::HTMLSanitization.sanitize('This is a test survey'),
      :value => 9, 
      :period => 1,
      :course_id => @course,
      :state => :published
    }

    Survey.should exist_with expected_attrs

    survey = Survey.last
    survey.should have(1).questions

    page.should show_survey_full_preview survey
    page.should have_notice t('flash.survey_created')

    Notification.should exist_with :user_id => student, :notificator_id => survey, :kind => 'student_survey_added'
  end

  scenario 'editing an existing survey', :js => true do
    student = Factory(:student)
    @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')

    survey   = Factory(:survey, :course => @course)
    question = survey.questions.first

    visit survey_url(survey, :subdomain => @network.subdomain)
    click_link t('surveys.show.edit_survey')
    questions = survey.questions
     
    page.should have_xpath("//input[@value='#{question.answer_uuid}' and @checked='checked']")
    new_answer_uuid = question.answers.first.uuid

    find("input[value='#{new_answer_uuid}']").set(true)
    fill_in 'survey[name]', :with => 'Edited survey'

    lambda do
      click_button t('formtastic.actions.update')
    end.should_not change(Survey, :count)

    survey.should have(1).question
    question = survey.questions.first
    question.reload
    question.answer_uuid.should === new_answer_uuid

    Survey.should exist_with :name => 'Edited survey'
    page.should have_notice t('flash.survey_updated')

    Notification.should exist_with :user_id => student, :notificator_id => survey, :kind => 'student_survey_updated'
  end

  scenario 'trying to edit a published survey' do
    survey = Factory(:published_survey, :course => @course)
    visit edit_survey_path survey
    current_url.should_not =~ /#{edit_survey_path(survey)}/
    put survey_path(survey), :survey => {:name => 'Edited survey'}
    Survey.should_not exist_with :name => 'Edited survey'
  end

  scenario 'viewing the detail of an survey' do
    survey = Factory(:survey, :course => @course)
    visit course_surveys_path @course

    page.should_not link_to edit_survey_reply_path survey

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

  scenario 'viewing a list of survey replies' do
    survey  = Factory(:survey, :course => @course)
    replies = 3.times.map do
      Factory(:survey_reply, :survey => survey)
    end

    visit survey_path survey
    click_link t('surveys.show.view_replies')

    page.should have_content survey.name
    page.should show_survey_reply_listing_for replies
  end

  scenario 'viewig a survey reply' do
    survey = Factory(:survey, :course => @course)
    reply  = Factory(:survey_reply, :survey => survey)

    visit survey_path survey
    click_link t('surveys.show.view_replies')
    # TODO: not testing if revealing correct or incorrect

    within ('.reply:last') do
      click_link t('teachers.survey_replies.index.show')
    end
    save_and_open_page
    page.should show_managed_survey_reply reply
  end 

  scenario 'publishing a survey with ajax', :js => true do
    survey = Factory(:survey, :course => @course)
    visit course_surveys_url @course, :subdomain => @network.subdomain
    within('.survey:last') do
      click_link t('surveys.survey.publish')
      sleep 10
    end
    Survey.should exist_with :state => :published
  end
end
