module NavigationHelpers
  def sign_in_with user, opts = {}
    user.confirm!
    if opts[:subdomain]
      visit root_url(:subdomain => opts[:subdomain])
    else
      visit root_path
    end
    fill_in 'user[email]', :with => user.email
    fill_in 'user[password]', :with => opts[:password] || 'password'
    click_button 'sign_in'
  end

  def sign_out
    visit root_path
    click_link 'Logout'
  end
end

module HelperMethods
  include NavigationHelpers
  include I18n
end

RSpec.configuration.include HelperMethods, :type => :acceptance
