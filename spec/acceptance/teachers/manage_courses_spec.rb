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
    @course.assignations.create(:user => @teacher, :admin => true)
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

    course = Course.last
    course.should_not be_nil
    course.name.should        == 'Introduction to algebra'
    course.description.should == 'course description'
    course.start_date.should  == Date.civil(2011,01,20)
    course.finish_date.should == Date.civil(2012,01,29)
    course.reference.should   == 'classroom A'
    course.public.should be_true
    course.network.should == @network
    course.teachers.should include(@teacher)
    course.teachers.where('assignations.admin' => true).should include(@teacher)

    page.should have_notice I18n.t('flash.course_created')
  end

  scenario 'update course' do
    course = Factory(:course, :assignations => [Assignation.create(:user => @teacher, :admin => true)], :network => @network)
    visit edit_course_url course, :subdomain => @network.subdomain
    fill_in 'course[name]', :with => 'Course updated'
    click_button 'submit'
    course.reload
    course.name.should == 'Course updated'
  end

  scenario 'view my courses' do
    courses = (1..3).map { Factory(:course, :teachers => [@teacher]) }
    (1..2).map { Factory(:course) }
    visit dashboard_url(:subdomain => @network.subdomain)
    page.should have_css('.course', :count => 4)
  end


  scenario 'View pending requests to join a course' do
    (1..3).map do
      student = Factory(:student, :networks => [@network])
      student.enrollments.create(:course => @course, :state => 'pending')
    end

    # These should not appear on the list
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'accepted')
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'rejected')

    visit requests_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.request', :count => 3)
  end


  scenario 'Accept a request to join a course' do
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'pending')

    visit requests_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.request', :count => 1)

    click_link 'Accept'

    page.current_url.should match requests_course_url(@course, :subdomain => @network.subdomain)
    page.should have_no_css('.requests')
    Enrollment.last.state = 'accepted'
  end


  scenario 'Reject a request to join a course' do
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'pending')

    visit requests_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.request', :count => 1)

    click_link 'Reject'

    page.current_url.should match requests_course_url(@course, :subdomain => @network.subdomain)
    page.should have_no_css('.requests')
    Enrollment.last.state = 'rejected'
  end


  scenario 'A student cannot go to the requests page' do
    student = Factory(:student, :networks => [@network])
    student.enrollments.create(:course => @course, :state => 'accepted')

    sign_out
    sign_in_with student, :subdomain => @network.subdomain

    visit requests_course_url(@course, :subdomain => @network.subdomain)
    page.current_url.should_not match requests_course_url(@course)
    page.current_url.should match dashboard_path
  end
end
