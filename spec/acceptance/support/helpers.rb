module HelperMethods
  def sign_in_with user, password = 'password'
    visit root_path
    fill_in 'user[email]', :with => user.email
    fill_in 'user[password]', :with => password
    click_button 'sign_in'
    User.last.confirm!
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
