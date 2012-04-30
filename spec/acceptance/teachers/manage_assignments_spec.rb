require 'spec_helper'

feature 'Manage assignments', %q{
  In order to let my students assignment work
  As a teacher
  I want use the system to create assignments
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher', :state => "accepted")
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  it_should_behave_like 'has basic actions for assignments'
  

  scenario 'creating an assignment' do
    student = Factory(:student)
    @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')

    visit course_assignments_url(@course, :subdomain => @network.subdomain)
    click_link 'new_assignment'
    fill_in 'assignment[name]',        :with => 'First assignment'
    fill_in 'assignment[description]', :with => 'This is a test assignment'
    fill_in 'assignment[value]',       :with => 9
    select '1', :from => 'assignment[period]'

    dt = DateTime.now
    #Start at
    select dt.year.to_s,    :from => 'assignment[start_at(1i)]'
    select month_number_to_name(dt.month),   :from => 'assignment[start_at(2i)]'
    select dt.day.to_s,      :from => 'assignment[start_at(3i)]'
    select dt.hour.to_s,       :from => 'assignment[start_at(4i)]'
    select dt.minute.to_s,      :from => 'assignment[start_at(5i)]'

    dt = dt+1.week
    # TODO: we need a select_date helper
    select dt.year.to_s,    :from => 'assignment[due_to(1i)]'
    select month_number_to_name(dt.month),   :from => 'assignment[due_to(2i)]'
    select dt.day.to_s,      :from => 'assignment[due_to(3i)]'
    select dt.hour.to_s,       :from => 'assignment[due_to(4i)]'
    select dt.minute.to_s,      :from => 'assignment[due_to(5i)]'

    lambda do
      click_button 'submit'
    end.should change(Assignment, :count).by(1)

    expected_attrs = {
      :name => 'First assignment', 
      :description => ActiveRecord::HTMLSanitization.sanitize('This is a test assignment'), 
      :value => 9, 
      :period => 1,
    }

    Assignment.should exist_with expected_attrs
    assignment = Assignment.last

    assignment.course.should == @course

    page.current_url.should match assignment_path(assignment)
    page.should show_assignment assignment
    page.should have_notice t('flash.assignment_created')

    Notification.should exist_with :user_id => student, :notificator_id => assignment, :kind => 'student_assignment_added'
  end

  scenario 'editing an existing assignment' do
    student = Factory(:student)
    @course.enrollments.create(:user => student, :role => 'student', :state => 'accepted')

    assignment = Factory(:assignment, :course => @course)
    visit assignment_url(assignment, :subdomain => @network.subdomain)
    click_link 'edit'
    fill_in 'assignment[name]', :with => 'Edited Assignment'
    click_button 'submit'
    Assignment.should exist_with :name => 'Edited Assignment'
    page.should have_notice t('flash.assignment_updated')

    Notification.should exist_with :user_id => student, :notificator_id => assignment, :kind => 'student_assignment_updated'
  end

  scenario 'removing an existing assignment' do
    assignment = Factory(:assignment, :course => @course)
    visit assignment_url(assignment, :subdomain => @network.subdomain)

    lambda do
      click_link 'delete'
    end.should change(Assignment, :count).by(-1)
    page.should have_notice t('flash.assignment_deleted')
    page.current_url.should match course_assignments_path(@course)
  end
end
