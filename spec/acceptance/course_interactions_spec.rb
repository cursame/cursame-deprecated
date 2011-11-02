require 'acceptance/acceptance_helper'

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

    @student.enrollments.create(:course => @course, :state => 'accepted')
    @teacher.assignations.create(:course => @course)

    sign_in_with @student, :subdomain => @network.subdomain
  end


  scenario 'View all students participating in this course' do
    (1..10).map do
      student = Factory(:student, :networks => [@network])
      student.enrollments.create(:course => @course, :state => 'accepted')
    end

    visit members_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.student', :count => 11) # 10 + the current student
  end


  scenario 'View teachers on this course' do
    other_teacher = Factory(:teacher, :networks => [@network])
    @course.assignations.create(:user => other_teacher)

    visit members_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.teacher', :count => 2)
  end


  scenario 'Should not include users from other courses' do
    other_course = Factory(:course, :network => @network)
    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => other_course, :state => 'accepted')

    visit members_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.student', :count => 1) # Just me

    page.should have_content(@student.email)
    page.should have_no_content(other_student.email)
  end


  scenario "Should not show students that haven't been accepted" do
    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => @course, :state => 'pending')

    visit members_course_url(@course, :subdomain => @network.subdomain)
    page.should have_no_content(other_student.email)
  end


  scenario 'Should not show students that haven been rejected' do
    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => @course, :state => 'rejected')

    visit members_course_url(@course, :subdomain => @network.subdomain)
    page.should have_no_content(other_student.email)
  end


  scenario 'As a teacher, the same tests as above apply' do
    sign_in_with @teacher, :subdomain => @network.subdomain

    (1..10).map do
      student = Factory(:student, :networks => [@network])
      student.enrollments.create(:course => @course, :state => 'accepted')
    end

    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => @course, :state => 'pending')

    other_student = Factory(:student, :networks => [@network])
    other_student.enrollments.create(:course => @course, :state => 'rejected')

    visit members_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.student', :count => 11)
    page.should have_css('.teacher', :count => 1)
  end
end
