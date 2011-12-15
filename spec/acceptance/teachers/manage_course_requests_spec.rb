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

  scenario 'view all pending students participating in this course' do
    (1..3).map do
      student = Factory(:student, :networks => [@network])
      student.enrollments.create(:course => @course, :state => 'pending', :role => 'student')
    end

    # These should not appear on the list
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'accepted')
    Factory(:student, :networks => [@network]).enrollments.create(:course => @course, :state => 'rejected')

    visit members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.pending.student', :count => 3)
  end

  scenario 'accept a request to join a course' do
    student    = Factory(:student)
    enrollment = Factory(:student_enrollment, :course => @course, :state => 'pending', :user => student)

    visit members_for_course_url(@course, :subdomain => @network.subdomain)

    within '.pending.student' do
      click_link t('courses.member.accept')
    end

    page.current_url.should match members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_css('.accepted.student', :count => 1)
    Enrollment.last.state.should == 'accepted'

    Notification.should exist_with :user_id => student, :notificator_id => enrollment, :kind => 'student_course_accepted'
  end

  scenario 'reject a request to join a course' do
    student    = Factory(:user)
    enrollment = Factory(:student_enrollment, :course => @course, :state => 'pending', :user => student)

    visit members_for_course_url(@course, :subdomain => @network.subdomain)

    within '.pending.student' do
      click_link t('courses.member.reject')
    end

    page.current_url.should match members_for_course_url(@course, :subdomain => @network.subdomain)
    page.should have_no_css('.student')
    Enrollment.last.state = 'rejected'

    Notification.should exist_with :user_id => student, :notificator_id => enrollment, :kind => 'student_course_rejected'
  end
end
