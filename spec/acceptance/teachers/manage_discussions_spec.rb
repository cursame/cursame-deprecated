require 'acceptance/acceptance_helper'

feature 'Manage discussions', %q{
  In order to solve doubts and interact
  As a teacher or students
  I want create and participate in discussions
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher')
    sign_in_with @teacher, :subdomain => @network.subdomain
  end


end
