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
    sign_in_with @user, :subdomain => @network.subdomain
  end

  scenario 'viewing a list of assignments' do
    pending
    assignments = (1..3).map { Factory(:assignment, :course => @course) }
    visit course_assignments_path course
    assignments.each do |assignment|
      page.should show_assignment_preview assignment
    end
  end

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
