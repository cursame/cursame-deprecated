require 'acceptance/acceptance_helper'

feature 'Manage courses', %q{
  In order to teach my course
  As a teacher
  I want to create and manage courses
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'creating a course' do
    visit new_course_url(:subdomain => @network.subdomain)
    fill_in 'course[name]',        :with => 'Introduction to algebra'
    fill_in 'course[description]', :with => 'course description'

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
    save_and_open_page
    fill_in 'course[name]', :with => 'Course updated'
    click_button 'submit'
    course.reload
    course.name.should == 'Course updated'
  end

  scenario 'view my courses' do
    courses = (1..3).map { Factory(:course, :teachers => [@teacher]) }
    (1..2).map { Factory(:course) }
    visit dashboard_url(:subdomain => @network.subdomain)
    page.should have_css('.course', :count => 3)
  end
end
