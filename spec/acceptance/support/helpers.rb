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

  def sign_out opts = {}
    if opts[:subdomain]
      visit root_url(:subdomain => opts[:subdomain])
    else
      visit root_path
    end
    click_link 'Logout'
  end
end

module HelperMethods
  include NavigationHelpers
  include I18n

  def t *args
    I18n.t *args
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
