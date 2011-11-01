require 'acceptance/acceptance_helper'

feature 'Manage courses', %q{
  In order to teach my course
  As a teacher
  I want to create and manage courses
} do

  scenario 'creating a course' do
    sign_in_with Factory(:teacher)
    visit new_course_path
    fill_in 'course[name]', :with => 'Introduction to algebra'
    fill_in 'course[description]', :with => 'course description'
  end
end
