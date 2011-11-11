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
    visit root_url(:subdomain => @network.subdomain)
    page.current_url.should match supervisor_path
  end

  scenario 'change my password' do
    new_password = 'my flipping great new password'

    visit settings_url(:subdomain => @network.subdomain)

    fill_in 'user[password]',              :with => new_password
    fill_in 'user[password_confirmation]', :with => new_password
    click_button 'submit'

    sign_in_with @supervisor, :password => new_password, :subdomain => @network.subdomain
    page.current_url.should match supervisor_path
  end

  context 'teacher listing and aproval/rejecting' do
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
      (1..3).map { Factory(:teacher, :networks => [@network], :state => 'inactive') }
      # Other users that are already approved
      (1..5).map { Factory(:teacher, :networks => [@network]) }
      (1..3).map { Factory(:student, :networks => [@network]) }

      #sign_in_with @supervisor, :subdomain => @network.subdomain
      click_link t('supervisors.show.pending_approvals')
      page.should have_css('.pending', :count => 3)
    end

    scenario 'accept a teacher registration' do
      pending = Factory(:teacher, :networks => [@network], :state => 'inactive')
      visit pending_approvals_supervisor_url(:subdomain => @network.subdomain)
      click_button t('supervisors.pending_approvals.approve')

      page.current_url.should match pending_approvals_supervisor_path
      page.should have_notice t('flash.user_registration_accepted')

      pending.reload
      pending.state.should == 'active'
    end

    scenario 'reject a teacher registration' do
      pending = Factory(:teacher, :networks => [@network], :state => 'inactive')
      visit pending_approvals_supervisor_url(:subdomain => @network.subdomain)
      click_button t('supervisors.pending_approvals.reject')

      page.current_url.should match pending_approvals_supervisor_path
      page.should have_notice t('flash.user_registration_rejected')

      User.unscoped.where(:id => pending.id).should be_empty
    end
  end

  context 'student listing' do
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
  end

  context 'permissions' do
    scenario 'a teacher cannot go to the supervisor panel' do
      sign_out :subdomain => @network.subdomain
      sign_in_with Factory(:teacher, :networks => [@network])

      visit supervisor_url(:subdomain => @network.subdomain)
      page.current_url.should match dashboard_path
    end

    scenario 'a student cannot go to the supervisor panel' do
      sign_out :subdomain => @network.subdomain
      sign_in_with Factory(:student, :networks => [@network])

      visit supervisor_url(:subdomain => @network.subdomain)
      page.current_url.should match dashboard_path
    end
  end

  context 'accessing course and course assets' do
    background do
      @course  = Factory(:course, :network => @network, :assignments => [Factory(:assignment)], :discussions => [Factory(:discussion)], :comments => [Factory(:comment)])
      @teacher = Factory(:teacher, :networks => [@network])
      Enrollment.create(:course => @course, :user => @teacher, :admin => true, :role => 'teacher')
    end

    scenario 'view a list of courses' do
      # These course if from other networks, and shouldn't appear on the page.
      Factory(:course)

      visit supervisor_url(:subdomain => @network.subdomain)
      click_link t('supervisors.show.courses')
      page.should have_css('.course', :count => 1)
    end

    scenario 'view a course' do
      visit courses_url(:subdomain => @network.subdomain)
      click_link @course.name

      page.current_url.should match course_path @course
      page.should have_content @course.name
      page.should have_content @course.description
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
