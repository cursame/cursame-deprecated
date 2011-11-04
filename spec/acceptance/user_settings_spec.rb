require 'acceptance/acceptance_helper'

feature 'User Settings', %q{
  In order to manage my preferences on the site
  As a registered User
  I want to set things like my password and shit like that.
} do

  background do
    @network = Factory(:network)
    @student = Factory(:student, :networks => [@network])
    sign_in_with @student, :subdomain => @network.subdomain
  end


  scenario 'View the settings page' do
    visit dashboard_url(:subdomain => @network.subdomain)
    click_link t('shared.toolbar.settings')

    page.should have_content t('settings.show.change_password')
  end


  scenario 'change my password' do
    new_password = 'my flipping great new password'

    visit settings_url(:subdomain => @network.subdomain)

    within('#change_password') do
      fill_in 'user[password]',              :with => new_password
      fill_in 'user[password_confirmation]', :with => new_password
      click_button 'submit'
    end

    # At this point Devise should have logged out us automatically

    sign_in_with @student, :password => new_password, :subdomain => @network.subdomain
    page.current_url.should match settings_path
  end
end
