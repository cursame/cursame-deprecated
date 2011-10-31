require 'acceptance/acceptance_helper'

feature 'User registration', %q{
  In order to use the application
  As a non registered user
  I want sign up
} do

  background do
    @network = Factory(:network) 
  end

  scenario 'signing up as student' do
    visit root_url(:subdomain => @network.subdomain)
    fill_in 'student_user[email]', :with => 'user@example.com'
    fill_in 'student_user[password]', :with => 'password'
    fill_in 'student_user[password_confirmation]', :with => 'password'
    click_button 'register'

    user = User.last
    user.should_not be_nil
    user.networks.should include @network
    user.role.should == 'student'
  end

  scenario 'signing up as teacher' do
    visit new_teacher_user_registration_url(:subdomain => @network.subdomain)
    fill_in 'teacher_user[email]', :with => 'user@example.com'
    fill_in 'teacher_user[password]', :with => 'password'
    fill_in 'teacher_user[password_confirmation]', :with => 'password'
    click_button 'register'

    user = User.last
    user.should_not be_nil
    user.networks.should include @network
    user.role.should == 'teacher'
  end
end
