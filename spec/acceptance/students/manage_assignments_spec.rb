require 'spec_helper'

feature 'Manage assignments', %q{
  In order to accomplish my course work
  As a student
  I want to see and complete assignments
} do

  background do
    @network = Factory(:network)
    @user    = Factory(:user, :networks => [@network])
    @course  = Factory(:course,  :network => @network)
    Enrollment.create(:course => @course, :user => @user, :admin => false, :role => 'student', :state => 'accepted')
    sign_in_with @user, :subdomain => @network.subdomain
  end

  it_should_behave_like 'has basic actions for assignments'
  
  
end
