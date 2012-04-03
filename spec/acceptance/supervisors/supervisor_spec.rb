require 'spec_helper'

feature 'Supervisor', %q{
  In order to manage my network
  As a supervisor
  I want to manage teachers/students/users/courses
} do

  background do
    @network    = Factory(:network)
    @supervisor = Factory(:supervisor, :networks => [@network])
    sign_in_with @supervisor, :subdomain => @network.subdomain
  end

  scenario 'redirect to /supervisor after signing in' do
    page.current_url.should match supervisor_dashboard_path
    visit root_url(:subdomain => @network.subdomain)
    page.current_url.should match supervisor_dashboard_path
  end

  scenario 'change my password' do
    new_password = 'my flipping great new password'

    visit settings_url(:subdomain => @network.subdomain)

    fill_in 'user[password]',              :with => new_password
    fill_in 'user[password_confirmation]', :with => new_password
    click_button 'submit'

    sign_in_with @supervisor, :password => new_password, :subdomain => @network.subdomain
    page.current_url.should match supervisor_dashboard_path
  end

  context 'teacher listing and aproval/rejecting' do
    scenario 'view the total number of teachers registered' do
      (1..3).map { Factory(:teacher, :networks => [@network]) }
      (1..3).map { Factory(:student, :networks => [@network]) }
      (1..3).map { Factory(:teacher) } # Other networks
      
      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      click_link t('supervisor.shared.admin_menu.teachers')
      
      page.should have_content("3 #{t('.supervisor.teachers.registered_teachers')}")
    end
    
    scenario 'view a list of teachers with tabs for approved and pending' do
      (1..3).map { Factory(:teacher, :networks => [@network]) }
      (1..3).map { Factory(:student, :networks => [@network]) }
      (1..3).map { Factory(:teacher) } # Other networks

      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      click_link t('supervisor.shared.admin_menu.teachers')
      
      page.should have_css('#approved')
      page.should have_css('#pending')
      page.should have_css('.teacher', :count => 3)
      page.should have_css('.teacher_aproval', :count => 3)
      page.should have_css('.accept')
      page.should have_css('.reject')
    end

    scenario 'view the details of a teacher' do
      teacher = Factory(:teacher, :networks => [@network])
      visit supervisor_teachers_url(:subdomain => @network.subdomain)
      click_link teacher.name

      page.current_url.should match user_path(teacher)
    end

    scenario 'view new teacher registrations' do
      (1..3).map { Factory(:teacher, :networks => [@network], :state => 'inactive') }
      # Other users that are already approved
      (1..5).map { Factory(:teacher, :networks => [@network]) }
      (1..3).map { Factory(:student, :networks => [@network]) }

      #sign_in_with @supervisor, :subdomain => @network.subdomain
      click_link t('supervisor.shared.admin_menu.teachers')
      click_link t('courses.teachers.pending')
      page.should have_css('.teacher_aproval')
    end

    scenario 'accept a teacher registration' do
      pending = Factory(:teacher, :networks => [@network], :state => 'inactive')
      visit supervisor_teachers_url(:subdomain => @network.subdomain)
      click_button t('supervisor.shared.teachers.approve')

      page.current_url.should match supervisor_teachers_path
      page.should have_notice t('flash.user_registration_accepted')

      pending.reload
      pending.state.should == 'active'
    end

    scenario 'reject a teacher registration' do
      pending = Factory(:teacher, :networks => [@network], :state => 'inactive')
      visit supervisor_teachers_url(:subdomain => @network.subdomain)
      click_button t('supervisor.shared.teachers.reject')

      page.current_url.should match supervisor_teachers_path
      page.should have_notice t('flash.user_registration_rejected')

      User.unscoped.where(:id => pending.id).should be_empty
    end
  end

  context 'student listing' do
    scenario 'view the total number of students registered' do
      (1..3).map { Factory(:teacher, :networks => [@network]) }
      (1..3).map { Factory(:student, :networks => [@network]) }
      (1..3).map { Factory(:teacher) } # Other networks
      
      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      click_link t('supervisor.shared.admin_menu.students')
      
      page.should have_content("3 #{t('.supervisor.students.registered_students')}")
    end
  
    scenario 'view a list of students' do
      (1..3).map { Factory(:teacher, :networks => [@network]) }
      (1..3).map { Factory(:student, :networks => [@network]) }
      (1..3).map { Factory(:student) } # Other networks

      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      click_link t('supervisor.shared.admin_menu.students') 
      page.should have_css('.student', :count => 3)
      page.should have_css('.edit_role', :count => 3)
      page.should have_css('.accept')
      page.should have_css('.reject')
    end

    scenario 'view the details of a student' do
      student = Factory(:student, :networks => [@network])
      visit supervisor_students_url(:subdomain => @network.subdomain)
      click_link student.name

      page.current_url.should match user_path(student)
    end
  end

  context 'permissions' do
    scenario 'a teacher cannot go to the supervisor panel' do
      sign_out :subdomain => @network.subdomain
      sign_in_with Factory(:teacher, :networks => [@network])

      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      page.current_url.should match dashboard_path
    end

    scenario 'a student cannot go to the supervisor panel' do
      sign_out :subdomain => @network.subdomain
      sign_in_with Factory(:student, :networks => [@network])

      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      page.current_url.should match dashboard_path
    end
  end
  
  context 'creating user' do
    scenario 'the form for creating a new user is show' do
      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      click_link t('supervisor.shared.admin_menu.new_user')
      
      page.should have_field('user_email')
      page.should have_field('user_first_name')
      page.should have_field('user_last_name')
      page.should have_select('user_role')
      have_button('commit')
    end
  end

  context 'accessing course and course assets' do
    background do
      @course  = Factory(:course, :network => @network, :assignments => [Factory(:assignment)], :discussions => [Factory(:discussion)], :comments => [Factory(:comment)])
      @teacher = Factory(:teacher, :networks => [@network])
      @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher')
    end

    scenario 'view a list of courses' do
      visit supervisor_dashboard_url(:subdomain => @network.subdomain)
      click_link t('supervisor.shared.admin_menu.courses')

      page.should have_css('.course', :count => Course.count)
    end

    scenario 'view a course' do
      visit courses_url(:subdomain => @network.subdomain)
      click_link @course.name

      page.current_url.should match course_path @course
      page.should show_course @course
    end

    scenario 'view a course wall' do
      visit wall_for_course_url @course, :subdomain => @network.subdomain
      page.should show_comment @course.comments.first
    end

    scenario 'view the discussion list' do
      visit course_url @course, :subdomain => @network.subdomain
      click_link 'Discusiones'

      @course.discussions.each do |discussion|
        page.should show_discussion_preview discussion
      end
    end

    scenario 'view a discussion' do
      visit course_discussions_url @course, :subdomain => @network.subdomain
      discussion = @course.discussions.first
      click_link discussion.title
      page.should show_discussion discussion
    end

    scenario 'view the assignment list' do
      visit course_url @course, :subdomain => @network.subdomain
      click_link 'Tareas'

      @course.assignments.each do |assignment|
        page.should show_assignment_preview assignment
      end
    end

    scenario 'view a assignment' do
      visit course_assignments_url @course, :subdomain => @network.subdomain
      assignment = @course.assignments.first
      click_link assignment.name
      page.should show_assignment assignment
    end
  end
end
