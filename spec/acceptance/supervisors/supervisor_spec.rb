require 'acceptance/acceptance_helper'

feature 'Supervisor', %q{
  In order to manage my network
  As a supervisor
  I want to manage teachers/students/courses
} do

  background do
    @network = Factory(:network)
    @supervisor = Factory(:supervisor, :networks => [@network])
    sign_in_with @supervisor, :subdomain => @network.subdomain
  end


  scenario 'redirect to /supervisor after signing in' do
    page.current_url.should match supervisor_path

    # Also if you go directly to root_path
    visit root_url(:subdomain => @network.subdomain)
    page.current_url.should match supervisor_path
  end


  scenario 'view a list of courses' do
    (1..3).map do
      course = Factory(:course, :network => @network)
      teacher = Factory(:teacher, :networks => [@network])
      Enrollment.create(:course => course, :user => teacher, :admin => true, :role => 'teacher')
    end

    # These courses are from other networks, and shouldn't appear on the page.
    (1..5).map { Factory(:course) }

    visit supervisor_url(:subdomain => @network.subdomain)
    click_link t('supervisors.show.courses')

    page.should have_css('.course', :count => 3)
  end


  scenario 'view a course' do
    course = Factory(:course, :network => @network)
    teacher = Factory(:teacher, :networks => [@network])
    Enrollment.create(:course => course, :user => teacher, :admin => true, :role => 'teacher')

    visit courses_supervisor_url(:subdomain => @network.subdomain)
    click_link course.name

    page.current_url.should match course_path(course)
    page.should have_content course.name
    page.should have_content course.description
  end


  scenario 'view a list of teachers' do
    (1..3).map { Factory(:teacher, :networks => [@network]) }
    (1..3).map { Factory(:student, :networks => [@network]) }
    (1..3).map { Factory(:teacher) } # Other networks

    visit supervisor_url(:subdomain => @network.subdomain)
    click_link t('supervisors.show.teachers')

    page.should have_css('.teacher', :count => 3)
  end


  scenario 'view the details of a teacher' do
    teacher = Factory(:teacher, :networks => [@network])
    visit teachers_supervisor_url(:subdomain => @network.subdomain)
    click_link teacher.name

    page.current_url.should match user_path(teacher)
  end


  scenario 'view new teacher registrations' do
    pending
  end


  scenario 'accept a teacher registration' do
    pending
  end


  scenario 'reject a teacher registration' do
    pending
  end


  scenario 'view a list of students' do
    (1..3).map { Factory(:teacher, :networks => [@network]) }
    (1..3).map { Factory(:student, :networks => [@network]) }
    (1..3).map { Factory(:student) } # Other networks

    visit supervisor_url(:subdomain => @network.subdomain)
    click_link t('supervisors.show.students') 
    page.should have_css('.student', :count => 3)
  end


  scenario 'view the details of a student' do
    student = Factory(:student, :networks => [@network])
    visit students_supervisor_url(:subdomain => @network.subdomain)
    click_link student.name

    page.current_url.should match user_path(student)
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

    sign_in_with @supervisor, :password => new_password, :subdomain => @network.subdomain
    page.current_url.should match settings_path
  end


  scenario 'a teacher cannot go to the supervisor panel' do
    sign_out :subdomain => @network.subdomain
    sign_in_with Factory(:teacher, :networks => [@network])

    visit supervisor_url(:subdomain => @network.subdomain)
    page.current_url.should match dashboard_path

    visit courses_supervisor_url(:subdomain => @network.subdomain)
    page.current_url.should match dashboard_path
  end


  scenario 'a student cannot go to the supervisor panel' do
    sign_out :subdomain => @network.subdomain
    sign_in_with Factory(:student, :networks => [@network])

    visit supervisor_url(:subdomain => @network.subdomain)
    page.current_url.should match dashboard_path

    visit courses_supervisor_url(:subdomain => @network.subdomain)
    page.current_url.should match dashboard_path
  end
end
