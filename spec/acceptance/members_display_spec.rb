require 'spec_helper'

feature 'Network members interaction', %q{
  In order to meet other members of the network
  As a user that have joined a network
  I want to be able to browse through all the members of the network
} do

  background do
    @network = Factory(:network)
    (1..3).map do
      @student = Factory(:student, :networks => [@network])
    end
    (1..3).map do
      teacher = Factory(:teacher, :networks => [@network])
    end

    sign_in_with @student, :subdomain => @network.subdomain
  end

  scenario 'view all users of this network on the dashboard, when the users are less than 30' do
    (1..3).map do
      student = Factory(:student, :networks => [@network])
    end

    visit dashboard_url(:subdomain => @network.subdomain)
    page.should have_css('.nav-member-avatars')
    page.should have_css('.nav-member-avatars li a', :count => 9)
  end
  
  scenario 'view at most 30 users of this network on the dashboard' do
    (1..30).map do
      student = Factory(:student, :networks => [@network])
    end
    
    visit dashboard_url(:subdomain => @network.subdomain)
    page.should have_css('.nav-member-avatars')
    page.should have_css('.nav-member-avatars li a', :count => 30)
    @network.users.count.should equal 36
  end
  
  scenario 'view all the users on the members for network view' do
    (1..30).map do
      student = Factory(:student, :networks => [@network])
    end
    
    visit dashboard_url(:subdomain => @network.subdomain)
    click_link "Ver todos"
    page.should have_css(".members-grid")
    page.should have_css(".network-members", :count => 36)
  end

  scenario 'search for a user member on the members grid view', :js => true do
    (1..29).map do
      student = Factory(:student, :networks => [@network])
    end
    student = Factory(:student, :networks => [@network], :first_name => "David", :last_name =>"Test One")

    visit dashboard_url(:subdomain => @network.subdomain)
    click_link "Ver todos"
    page.should have_css(".network-members", :count => 36)

    fill_in 'search', :with => "David Test"
    click_button 'Buscar usuario'

    page.should have_css(".members-grid")
    page.should have_css(".network-members", :count => 1)
  end
end
