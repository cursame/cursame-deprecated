require 'acceptance/acceptance_helper'

feature 'Manage courses', %q{
  In order to teach my course
  As a teacher
  I want to create and manage courses
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course = Factory(:course, :network => @network)
    @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher')
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'creating a course' do
    visit new_course_url(:subdomain => @network.subdomain)
    fill_in 'course[name]',        :with => 'Introduction to algebra'
    fill_in 'course[description]', :with => 'course description'

    # TODO: we need a select_date helper
    select '2011',    :from => 'course[start_date(1i)]'
    select 'enero',   :from => 'course[start_date(2i)]'
    select '20',      :from => 'course[start_date(3i)]'

    select '2012',    :from => 'course[finish_date(1i)]'
    select 'enero',   :from => 'course[finish_date(2i)]'
    select '29',      :from => 'course[finish_date(3i)]'

    fill_in 'course[reference]', :with => 'classroom A'
    check 'course[public]'

    lambda do
      click_button 'submit'
    end.should change(Course, :count)

    Course.should exist_with :name => 'Introduction to algebra',
      :name => 'Introduction to algebra',
      :description => 'course description',
      :start_date => Date.civil(2011,01,20),
      :finish_date => Date.civil(2012,01,29),
      :reference  => 'classroom A',
      :public => true

    course = Course.last
    course.network.should == @network
    course.teachers.should include(@teacher)
    course.teachers.where('enrollments.admin' => true).should include(@teacher)
    page.should have_notice I18n.t('flash.course_created')
  end

  scenario 'update course' do
    visit edit_course_url @course, :subdomain => @network.subdomain
    fill_in 'course[name]', :with => 'Course updated'
    click_button 'submit'
    @course.reload
    @course.name.should == 'Course updated'
  end

  scenario 'view my courses' do
    courses = (1..3).map { Factory(:course, :enrollments => [Factory(:student_enrollment, :user => @teacher)], :network => @network) }
    (1..2).map { Factory(:course, :network => @network) }
    visit dashboard_url(:subdomain => @network.subdomain)
    page.should have_css('.course-detail', :count => 4)
  end

  scenario 'View pending requests to join a course' do
    (1..3).map do
      student = Factory(:student, :networks => [@network])
      student.enrollments.create(:course => @course, :state => 'pending', :role => 'student')
    end

    # These should not appear on the list
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'accepted')
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'rejected')

    visit course_requests_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.request', :count => 3)
  end

  scenario 'Accept a request to join a course' do
    Factory(:student_enrollment, :course => @course, :state => 'pending', :user => Factory(:user))

    visit course_requests_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.request', :count => 1)

    click_link 'Accept'

    page.current_url.should match course_requests_url(@course, :subdomain => @network.subdomain)
    page.should have_no_css('.requests')
    Enrollment.last.state.should == 'accepted'
  end

  scenario 'Reject a request to join a course' do
    Factory(:student_enrollment, :course => @course, :state => 'pending', :user => Factory(:user))

    visit course_requests_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.request', :count => 1)

    click_link 'Reject'

    page.current_url.should match course_requests_url(@course, :subdomain => @network.subdomain)
    page.should have_no_css('.requests')
    Enrollment.last.state = 'rejected'
  end


  scenario 'A student cannot go to the requests page' do
    student = Factory(:student, :networks => [@network])
    student.enrollments.create(:course => @course, :state => 'accepted')

    sign_out
    sign_in_with student, :subdomain => @network.subdomain

    visit course_requests_url(@course, :subdomain => @network.subdomain)
    page.current_url.should_not match course_requests_url(@course)
    page.current_url.should match dashboard_path
  end
end
