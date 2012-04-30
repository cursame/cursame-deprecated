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
    @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher', :state => "accepted")
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'viewing a list of surveys', :js => true do
    surveys = (1..3).map { Factory(:published_survey, :course => @course) }
    (1..3).map { surveys << Factory(:survey, :course => @course) }
    (1..3).map { surveys << Factory(:published_finished_survey, :course => @course) }
    visit course_surveys_url @course, :subdomain => @network.subdomain

    surveys.each do |survey|
      page.should show_survey_preview survey if survey.published? and !survey.expired?
    end

    click_link 'Cerrados'

    surveys.each do |survey|
      page.should show_survey_preview survey if survey.published? and survey.expired?
    end

    click_link 'No publicados'

    surveys.each do |survey|
      page.should show_survey_preview survey if survey.unpublished?
    end
  end

  scenario 'creating a survey without publishing', :js => true do
    student = Factory(:student)
    @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')

    visit course_surveys_url(@course, :subdomain => @network.subdomain)
    click_link t('surveys.index.new_survey')

    fill_in 'survey[name]',        :with => 'First survey'
#    fill_in 'survey[description]', :with => 'This is a test survey'
    fill_in 'survey[value]',       :with => 9
    select '1', :from => 'survey[period]'

    time_start_at = DateTime.now + 1.day
    time_due_to = time_start_at+1.month
# TODO: we need a select_date helper
    select time_due_to.year.to_s,    :from => 'survey[due_to(1i)]'
    select month_number_to_name(time_due_to.month),   :from => 'survey[due_to(2i)]'
    select time_due_to.day.to_s,      :from => 'survey[due_to(3i)]'
    select time_due_to.hour.to_s,       :from => 'survey[due_to(4i)]'
    select time_due_to.minute.to_s,      :from => 'survey[due_to(5i)]'

    # TODO: we need a select_date helper
    select time_start_at.year.to_s,    :from => 'survey[start_at(1i)]'
    select month_number_to_name(time_start_at.month),   :from => 'survey[start_at(2i)]'
    select time_start_at.day.to_s,      :from => 'survey[start_at(3i)]'
    select time_start_at.hour.to_s,       :from => 'survey[start_at(4i)]'
    select time_start_at.minute.to_s,      :from => 'survey[start_at(5i)]'

    add_question_with_answers 'A, B or C?'
    add_question_with_answers 'A, B or C?'

    lambda do
      click_button t('formtastic.actions.create')
    end.should change(Survey, :count).by(1)

    expected_attrs = {
        :name => 'First survey',
        #      :description => ActiveRecord::HTMLSanitization.sanitize('This is a test survey'),
        :value => 9,
        :period => 1,
        :course_id => @course,
        :state => "unpublished"
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

  scenario 'trying to create a survey without setting a correct answer for a question', :js => true do
    visit new_course_survey_url(@course, :subdomain => @network.subdomain)

    fill_in 'survey[name]',        :with => 'First survey'
#    fill_in 'survey[description]', :with => 'This is a test survey'
    fill_in 'survey[value]',       :with => 9
    select '1', :from => 'survey[period]'

    # TODO: we need a select_date helper
    select '2011',    :from => 'survey[due_to(1i)]'
    select 'enero',   :from => 'survey[due_to(2i)]'
    select '20',      :from => 'survey[due_to(3i)]'
    select '8',       :from => 'survey[due_to(4i)]'
    select '30',      :from => 'survey[due_to(5i)]'

    add_question_with_answers 'A, B or C?'

    within 'fieldset.answer:last' do
      # remove last answer for question, the only way I could find
      # to simulate no radio chosen
      click_link 'Eliminar'
    end

    lambda do
      click_button t('formtastic.actions.create')
    end.should_not change(Survey, :count)

    page.should have_content I18n.t('activerecord.errors.question.missing_correct_answer')
  end

  scenario 'creating a survey with publishing', :js => true do
    student = Factory(:student)
    @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')

    visit course_surveys_url(@course, :subdomain => @network.subdomain)
    click_link t('surveys.index.new_survey')

    fill_in 'survey[name]',        :with => 'First survey'
#    fill_in 'survey[description]', :with => 'This is a test survey'
    fill_in 'survey[value]',       :with => 9
    select '1', :from => 'survey[period]'

    time_start_at = DateTime.now
    time_due_to = time_start_at+1.month
# TODO: we need a select_date helper
    select time_due_to.year.to_s,    :from => 'survey[due_to(1i)]'
    select month_number_to_name(time_due_to.month),   :from => 'survey[due_to(2i)]'
    select time_due_to.day.to_s,      :from => 'survey[due_to(3i)]'
    select time_due_to.hour.to_s,       :from => 'survey[due_to(4i)]'
    select time_due_to.minute.to_s,      :from => 'survey[due_to(5i)]'

    # TODO: we need a select_date helper
    select time_start_at.year.to_s,    :from => 'survey[start_at(1i)]'
    select month_number_to_name(time_start_at.month),   :from => 'survey[start_at(2i)]'
    select time_start_at.day.to_s,      :from => 'survey[start_at(3i)]'
    select time_start_at.hour.to_s,       :from => 'survey[start_at(4i)]'
    select time_start_at.minute.to_s,      :from => 'survey[start_at(5i)]'

    add_question_with_answers 'A, B or C?'

    lambda do
      click_button t('formtastic.actions.create')
    end.should change(Survey, :count).by(1)

    expected_attrs = {
        :name => 'First survey',
        #      :description => ActiveRecord::HTMLSanitization.sanitize('This is a test survey'),
        :value => 9,
        :period => 1,
        :course_id => @course,
        :state => "published"
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
  end

  scenario 'editing an existing survey and publish it', :js => true do
    survey   = Factory(:survey, :course => @course)
    visit edit_survey_url(survey, :subdomain => @network.subdomain)

    fill_in 'survey[name]', :with => 'Edited survey'

    time_start_at = DateTime.now
    # TODO: we need a select_date helper
    select time_start_at.year.to_s,    :from => 'survey[start_at(1i)]'
    select month_number_to_name(time_start_at.month),   :from => 'survey[start_at(2i)]'
    select time_start_at.day.to_s,      :from => 'survey[start_at(3i)]'
    select time_start_at.hour.to_s,       :from => 'survey[start_at(4i)]'
    select time_start_at.minute.to_s,      :from => 'survey[start_at(5i)]'

    lambda do
      click_button t('formtastic.actions.update')
    end.should_not change(Survey, :count)

    Survey.should exist_with :name => 'Edited survey', :state => "published"
    page.should have_notice t('flash.survey_updated')
  end

  scenario 'trying to edit an existing survey with not passing validation' do
    survey   = Factory(:survey, :course => @course)
    question = survey.questions.first

    visit edit_survey_url(survey, :subdomain => @network.subdomain)
    fill_in 'survey[name]', :with => ''
    click_button t('formtastic.actions.update')
    within '#survey_name_input' do
      page.should have_content t('errors.messages.blank')
    end
    Survey.should_not exist_with :name => ''
  end

  scenario 'trying to edit a survey removing a correct answer for a question', :js => true do
    survey   = Factory(:survey, :course => @course)
    question = survey.questions.first

    visit edit_survey_url(survey, :subdomain => @network.subdomain)
    fill_in 'survey[name]', :with => 'Edited'
    within 'fieldset.answer:last' do
      click_link 'Eliminar'
    end

    click_button t('formtastic.actions.update')

    Survey.should_not exist_with :name => 'Edited'
    page.should have_content I18n.t('activerecord.errors.question.missing_correct_answer')
  end

  scenario 'trying to edit a published survey' do
    survey = Factory(:published_survey, :course => @course)
    visit survey_path(survey)
    page.should_not link_to edit_survey_path(survey)
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
      click_link t('surveys.show.delete')
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
    page.should show_managed_survey_reply reply
  end

#  scenario 'publishing a survey with ajax', :js => true do
#    survey = Factory(:survey, :course => @course)
#    visit course_surveys_url @course, :subdomain => @network.subdomain
#    within('.survey:last') do
#      click_link t('surveys.survey.publish')
#      page.should have_content t('surveys.survey.published')
#    end

#    Survey.should exist_with :state => :published
#  end
end
