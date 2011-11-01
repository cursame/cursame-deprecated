module HelperMethods
  def sign_in_with user, password = 'password'
    user.confirm!
    visit root_path
    fill_in 'user[email]', :with => user.email
    fill_in 'user[password]', :with => password
    click_button 'sign_in'
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
