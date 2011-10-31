require 'acceptance/acceptance_helper'

feature 'User registration', %q{
  In order to use the application
  As a non registered user
  I want sign up
} do

  scenario 'signing up as student' do
    visit new_student_user_registration_path
  end
end
