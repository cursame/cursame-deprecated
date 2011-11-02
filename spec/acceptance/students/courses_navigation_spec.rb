require 'acceptance/acceptance_helper'

feature 'Course navigation', %q{
  In order to join a course
  As a registered student
  I want search/view/join courses
} do

  background do
    @network = Factory(:network)
    @student = Factory(:student, :networks => [@network])
    sign_in_with @student, :subdomain => @network.subdomain
  end

  scenario 'List all available courses' do
    courses = (1..5).map { Factory(:course, :network => @network) }
    visit courses_url(:subdomain => @network.subdomain)
    page.should have_css('.course', :count => 5)
  end


  scenario 'Join a course' do
    course = Factory(:course, :network => @network)
    visit courses_url(:subdomain => @network.subdomain)
    click_link 'Join'

    # should redirect to show page
    page.current_url.should match course_path(course)

    @student.enrollments.count.should == 1
  end

  scenario 'Cannot create two requests to join the same course' do
    course = Factory(:course, :network => @network)
    visit courses_url(:subdomain => @network.subdomain)
    click_link 'Join'

    @student.enrollments.count.should == 1

    # Repeat
    visit courses_url(:subdomain => @network.subdomain)
    click_link 'Join'

    @student.enrollments.count.should == 1
  end
end
