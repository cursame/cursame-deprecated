require 'acceptance/acceptance_helper'

feature 'Manage assignments', %q{
  In order to accomplish my course work
  As a student
  I want to see and complete assignments
} do

  background do
    @network = Factory(:network)
    @user    = Factory(:user, :networks => [@network])
    @course  = Factory(:course,  :network => @network)
    Enrollment.create(:course => @course, :user => @user, :admin => false, :role => 'student')
    sign_in_with @user, :subdomain => @network.subdomain
  end

  it_should_behave_like 'has basic actions for assignments'

  # TODO: this should go in a shared example group and be ran with student and teacher

  scenario 'viewing the detail of an assignment' do
    pending
    assignment = Factory(:assignment, :course => @course)
    visit course_assignments_path course

    within('.assignment:last') do
      click_link t('show_details')
    end

    page.should show_assignment assignment
  end

  # scenario 'commenting on an assignment' do
  #   pending
  # end
  # scenario 'commenting on an assignment comment' do
  #   pending
  # end
end
