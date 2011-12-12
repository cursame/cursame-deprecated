require 'acceptance/acceptance_helper'

feature 'Manage profile wall', %q{
  In order to socialize
  As a teacher or student
  I want to access my profile and profile for other users of the network
} do

  background do
    @network = Factory(:network)
    @user    = Factory(:user, :networks => [@network])
    @user2   = Factory(:user, :networks => [@network])
    Enrollment.create(:course => @course, :user => @user, :admin => false, :role => 'student', :state => 'accepted')
    sign_in_with @user, :subdomain => @network.subdomain
  end

  scenario 'viewing my own profile' do
    visit user_url @user, :subdomain => @network.subdomain
    page.should show_user @user
  end

  scenario 'viewing others profile' do
    visit user_url @user2, :subdomain => @network.subdomain
    page.should show_user @user2
  end
  
  scenario 'editing my profile' do
    pending
  end
end
