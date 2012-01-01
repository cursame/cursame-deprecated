require 'spec_helper'

feature 'Course interactions', %q{
  In order to participate in a course
  As a student/teacher that have joined a course
  I want to see it's info, and add content to it
} do

  background do
    @network = Factory(:network)
    @student = Factory(:student, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    @teacher = Factory(:teacher, :networks => [@network])

    @student.enrollments.create(:course => @course, :state => 'accepted', :role => 'student')
    @teacher.enrollments.create(:course => @course, :admin => true, :role => 'teacher')

    sign_in_with @student, :subdomain => @network.subdomain
  end

  scenario 'view all students participating in this course' do
    (1..3).map do
      student = Factory(:student, :networks => [@network])
      student.enrollments.create(:course => @course, :state => 'accepted', :role => 'student')
    end

    visit members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.accepted.student', :count => 4) # plus me
  end

  scenario 'view teachers on this course' do
    other_teacher = Factory(:teacher, :networks => [@network])
    @course.enrollments.create(:user => other_teacher, :admin => 'true', :role => 'teacher')

    visit members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.teacher', :count => 2)
  end

  scenario 'should not include users from other courses' do
    other_course  = Factory(:course, :network => @network)
    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => other_course, :state => 'accepted')

    visit members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.accepted.student', :count => 1) # Just me

    page.should have_content(@student.email)
    page.should have_no_content(other_student.email)
  end

  scenario "should not show students that haven't been accepted" do
    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => @course, :state => 'pending')

    visit members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_no_content(other_student.email)
  end

  scenario 'should not show students that haven been rejected' do
    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => @course, :state => 'rejected')

    visit members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_no_content(other_student.email)
  end

  scenario 'as a teacher, the same tests as above apply' do
    sign_out
    sign_in_with @teacher, :subdomain => @network.subdomain
    visit members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.accepted.student', :count => 1)
    page.should have_css('.teacher', :count => 1)
  end
end
