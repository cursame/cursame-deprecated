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
    click_link I18n.t('courses.index.request_join')

    # should redirect to show page
    page.current_url.should match course_path(course)

    @student.enrollments.count.should == 1
  end

  scenario 'Cannot create two requests to join the same course' do
    course = Factory(:course, :network => @network)
    visit courses_url(:subdomain => @network.subdomain)
    click_link I18n.t('courses.index.request_join')

    @student.enrollments.count.should == 1

    # Since the view does not have a link to request again,
    # we must manually fire a post request
    page.driver.post(join_course_url(course, :subdomain => @network.subdomain))
    page.current_url.should match course_path(course)

    @student.enrollments.count.should == 1
  end
end
