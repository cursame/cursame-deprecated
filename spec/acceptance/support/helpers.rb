module HelperMethods
  def sign_in_with user, opts = {}
    if opts[:subdomain]
      visit root_url(:subdomain => opts[:subdomain])
    else
      visit root_path
    end

    fill_in 'user[email]', :with => user.email
    fill_in 'user[password]', :with => opts[:password] || 'password'
    click_button 'sign_in'
    save_and_open_page
    User.last.confirm!
  end


end

RSpec.configuration.include HelperMethods, :type => :acceptance
