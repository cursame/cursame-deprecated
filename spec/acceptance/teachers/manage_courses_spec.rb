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
    fill_in 'course[start_date]',  :with => '20-01-2011'
    fill_in 'course[finish_date]', :with => '29-01-2012'

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
    courses = (1..3).map { Factory(:course, :enrollments => [Factory(:teacher_enrollment, :user => @teacher)], :network => @network) }
    (1..2).map { Factory(:course, :network => @network) }
    visit dashboard_url(:subdomain => @network.subdomain)
    page.should have_css('.course-detail', :count => 4)
  end
end
