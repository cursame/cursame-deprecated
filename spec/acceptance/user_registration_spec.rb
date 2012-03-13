require 'spec_helper'

feature 'User registration', %q{
  In order to use the application
  As a non registered user
  I want sign up
} do

  background do
    @network = Factory(:network) 
  end
  
  context 'registration is not restricted to a certain email domain' do
    scenario 'signing up as student' do
      visit root_url(:subdomain => @network.subdomain)
      fill_in 'student_user[first_name]', :with => 'Macario'
      fill_in 'student_user[last_name]',  :with => 'Ortega'
      fill_in 'student_user[email]',      :with => 'user@example.com'
      fill_in 'student_user[password]',   :with => 'password'
      fill_in 'student_user[password_confirmation]', :with => 'password'
      check 'student_user[terms_of_service]'

      click_button 'register'

      user = User.last
      user.should_not be_nil
      user.networks.should include @network
      user.role.should == 'student'
      user.state.should == 'active'
    end

    scenario 'signing up as teacher' do
      visit new_teacher_user_registration_url(:subdomain => @network.subdomain)
      fill_in 'teacher_user[first_name]', :with => 'Macario'
      fill_in 'teacher_user[last_name]',  :with => 'Ortega'
      fill_in 'teacher_user[email]', :with => 'user@example.com'
      fill_in 'teacher_user[password]', :with => 'password'
      fill_in 'teacher_user[password_confirmation]', :with => 'password'
      check 'teacher_user[terms_of_service]'
      click_button 'register'

      user = User.unscoped.last
      user.should_not be_nil
      user.networks.should include @network
      user.role.should == 'teacher'
      user.state.should == 'inactive'
    end
  end
  
  context 'registration is restricted to a certain email domain' do
    
    before do
      @network.update_attributes({:private_registry => true, :registry_domain => "innku.com"})
    end
    
    scenario 'signing up as student with a non permitted email' do
      visit root_url(:subdomain => @network.subdomain)
      fill_in 'student_user[first_name]', :with => 'Macario'
      fill_in 'student_user[last_name]',  :with => 'Ortega'
      fill_in 'student_user[email]',      :with => 'user@example.com'
      fill_in 'student_user[password]',   :with => 'password'
      fill_in 'student_user[password_confirmation]', :with => 'password'
      check 'student_user[terms_of_service]'

      click_button 'register'

      user = User.find_by_email 'user@example.com'
      user.should be_nil
      page.should have_content t('.user.errors.email_not_allowed')
    end

    scenario 'signing up as teacher with a non permitted email' do
      visit new_teacher_user_registration_url(:subdomain => @network.subdomain)
      fill_in 'teacher_user[first_name]', :with => 'Macario'
      fill_in 'teacher_user[last_name]',  :with => 'Ortega'
      fill_in 'teacher_user[email]', :with => 'user@example.com'
      fill_in 'teacher_user[password]', :with => 'password'
      fill_in 'teacher_user[password_confirmation]', :with => 'password'
      check 'teacher_user[terms_of_service]'
      click_button 'register'

      user = User.unscoped.find_by_email 'user@example.com'
      user.should be_nil
      page.should have_content t('.user.errors.email_not_allowed')
    end
    
    scenario 'signing up as student with a permitted email' do
      visit root_url(:subdomain => @network.subdomain)
      fill_in 'student_user[first_name]', :with => 'Macario'
      fill_in 'student_user[last_name]',  :with => 'Ortega'
      fill_in 'student_user[email]',      :with => 'alumno@innku.com'
      fill_in 'student_user[password]',   :with => 'password'
      fill_in 'student_user[password_confirmation]', :with => 'password'
      check 'student_user[terms_of_service]'

      click_button 'register'

      user = User.last
      user.should_not be_nil
      user.networks.should include @network
      user.role.should == 'student'
      user.state.should == 'active'
    end

    scenario 'signing up as teacher with a permitted email' do
      visit new_teacher_user_registration_url(:subdomain => @network.subdomain)
      fill_in 'teacher_user[first_name]', :with => 'Macario'
      fill_in 'teacher_user[last_name]',  :with => 'Ortega'
      fill_in 'teacher_user[email]', :with => 'maestro@innku.com'
      fill_in 'teacher_user[password]', :with => 'password'
      fill_in 'teacher_user[password_confirmation]', :with => 'password'
      check 'teacher_user[terms_of_service]'
      click_button 'register'

      user = User.find_by_email("maestro@innku.com")
      user.should_not be_nil
      user.networks.should include @network
      user.role.should == 'teacher'
      user.state.should == 'inactive'
    end
  end

  scenario 'signing in' do
    sign_in_with Factory(:confirmed_user, :networks => [@network]), :subdomain => @network.subdomain
    page.should have_notice t('devise.sessions.signed_in')
  end

  scenario 'a teacher cannot sign in without being approved' do
    sign_in_with Factory(:teacher, :networks => [@network], :state => 'inactive'), :subdomain => @network.subdomain
    page.current_url.should match root_path
    page.should have_error t('flash.account_not_active')
  end

  scenario 'a teacher can sign in after being approved' do
    sign_in_with Factory(:teacher, :networks => [@network], :state => 'active'), :subdomain => @network.subdomain
    page.should have_notice t('devise.sessions.signed_in')
  end

  scenario 'trying to signing in to non belonging network' do
    sign_in_with Factory(:confirmed_user, :networks => [@network]), :subdomain => Factory(:network).subdomain
    page.should have_error t('flash.wrong_network')
    page.current_url.should match root_path
  end
  
  scenario 'register box does not appear if the registry is not open' do
    @network.update_attribute(:public_registry, false)
    
    visit root_url :subdomain => @network.subdomain
    page.should_not have_css '.register-box'
    visit new_teacher_user_registration_url :subdomain => @network.subdomain
    page.should_not have_css '.register-box'
  end
end
