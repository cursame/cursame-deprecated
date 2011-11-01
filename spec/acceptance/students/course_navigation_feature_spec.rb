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
end
