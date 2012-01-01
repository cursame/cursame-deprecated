require 'spec_helper'

feature 'SuperAdmin', %q{
  In order to manage networks
  As a super admin
  I want to super admin like a boss
} do

  background do
    @admin = Factory.build(:admin)
    @admin.save(:validate => false)

    @network_attrs = {
      :name => 'A brand new kick-ass network',
      :subdomain => 'foo-bar-baz'
    }

    @user_attrs = {
      :role       => 'supervisor',
      :first_name => 'Mr. Supervisor',
      :last_name  => 'of the School',
      :email      => 'supervisor@example.com'
    }
    
    sign_in_with @admin
  end

  scenario 'redirect to /admin after signing in' do
    page.current_url.should match admin_path

    # Also if you go directly to root_path
    visit root_path
    page.current_url.should match admin_path
  end

  scenario 'create a new network (and its supervisor)' do
    visit admin_networks_path
    click_link 'New Network'
    fill_in 'network[name]',      :with => @network_attrs[:name]
    fill_in 'network[subdomain]', :with => @network_attrs[:subdomain]
    fill_in 'network[supervisors_attributes][0][first_name]', :with => @user_attrs[:first_name]
    fill_in 'network[supervisors_attributes][0][last_name]',  :with => @user_attrs[:last_name]
    fill_in 'network[supervisors_attributes][0][email]',      :with => @user_attrs[:email]
    fill_in 'network[supervisors_attributes][0][password]',   :with => 'secretsecret'
    fill_in 'network[supervisors_attributes][0][password_confirmation]', :with => 'secretsecret'
    # click_button 'submit'
    # Network.should exist_with @network_attrs
    # User.should exist_with @user_attrs
    # page.current_url.should match admin_network_path(Network.last)
    # page.should have_notice I18n.t('flash.network_created')
  end

  scenario 'view a list of existing networks' do
    network1 = Factory(:network)
    network2 = Factory(:network)
    network3 = Factory(:network)

    visit admin_path
    click_link 'Networks'

    page.should have_css('.network', :count => 3)
  end

  scenario 'view the details of an existing network' do
    network = Factory(:network)
    visit admin_networks_path
    click_link network.name

    page.current_url.should match admin_network_path(network)
    page.should have_content network.name
    page.should have_content network.subdomain
  end

  scenario 'edit an existing network' do
    network = Factory(:network)

    visit admin_network_path(network)
    click_link 'Edit'

    fill_in 'network[name]', :with => 'Some other name for network'
    fill_in 'network[subdomain]', :with => 'other-subdomain'

    click_button 'submit'

    page.current_url.should match admin_network_path(network)
    page.should have_content 'Some other name for network'
    page.should have_content 'other-subdomain'
    page.should have_notice I18n.t('flash.network_updated')
  end

  scenario 'a teacher cannot go to the admin panel' do
    sign_out
    network = Factory(:network)
    teacher = Factory(:teacher, :networks => [network])
    sign_in_with teacher, :subdomain => network.subdomain

    visit admin_url(:subdomain => network.subdomain)
    page.current_url.should match dashboard_path

    visit admin_networks_path
    page.current_url.should match dashboard_path
  end

  scenario 'a student cannot go to the admin panel' do
    sign_out
    network = Factory(:network)
    student = Factory(:student, :networks => [network])
    sign_in_with student, :subdomain => network.subdomain

    visit admin_url(:subdomain => network.subdomain)

    page.current_url.should match dashboard_path

    visit admin_networks_path
    page.current_url.should match dashboard_path
  end
end
