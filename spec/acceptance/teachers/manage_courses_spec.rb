require 'acceptance/acceptance_helper'

feature 'Manage courses', %q{
  In order to teach my course
  As a teacher
  I want to create and manage courses
} do

  scenario 'creating a course' do
    teacher = Factory(:teacher)

    sign_in_with teacher
    visit new_course_path
    fill_in 'course[name]', :with => 'Introduction to algebra'
    fill_in 'course[description]', :with => 'course description'

    select '2011', :from => 'course[start_date(1i)]'
    select 'January', :from => 'course[start_date(2i)]'
    select '20', :from => 'course[start_date(3i)]'

    select '2011', :from => 'course[finish_date(1i)]'
    select 'May', :from => 'course[finish_date(2i)]'
    select '29', :from => 'course[finish_date(3i)]'

    fill_in 'course[reference]', :with => 'classroom A'
    check 'course[public]'

    click_button 'submit'

    course = Course.last
    course.should_not be_nil
    course.name.should == 'Introduction to algebra'
    course.description.should == 'course description'
    course.start_date.should == Date.civil(2011,01,20)
    course.finish_date.should == Date.civil(2011,05,29)
    course.reference.should == 'classroom A'
    course.public.should be_true

    course.teachers.should include(teacher)
    course.teachers.where('assignations.admin' => true).should include(teacher)

    page.should have_notice I18n.t('flash.course_created')
  end
end
