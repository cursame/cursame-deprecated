require 'acceptance/acceptance_helper'

feature 'Surveys', %q{
  In order to acomplish course
  As a student
  I want answer surveys
} do

  background do
    @network = Factory(:network)
    @student = Factory(:student, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    @survey  = Factory(:survey, :course => @course)
    @course.enrollments.create(:user => @student, :role => 'student')
    sign_in_with @student, :subdomain => @network.subdomain
  end

end
