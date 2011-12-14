require 'acceptance/acceptance_helper'

feature 'Manage assignments', %q{
  In order to evaluate students
  As a teacher
  I want to view and comment assignments
} do

  background do
    @network    = Factory(:network)
    @student    = Factory(:user, :networks => [@network])
    @teacher    = Factory(:user, :networks => [@network])
    @course     = Factory(:course,  :network => @network)
    @assignment = Factory(:assignment, :course => @course)
    @delivery   = Factory(:delivery, :assignment => @assignment, :user => @student)
    @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher')
    @course.enrollments.create(:user => @student, :admin => true, :role => 'student')
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'viewing deliveries for an assignment' do
    deliveries = [@delivery] + 1.upto(2).map { Factory(:delivery, :assignment => @assignment)}
    visit assignment_url @assignment, :subdomain => @network.subdomain
    click_link t('assignments.show.deliveries')

    deliveries.each do |delivery|
      page.should show_delivery_preview delivery
    end
    page.should show_assignment_preview @assignment
  end

  scenario 'viewing a delivery for an assignment' do
    visit assignment_url @assignment, :subdomain => @network.subdomain
    click_link t('assignments.show.deliveries')

    within '.delivery:last' do
      click_link t('teachers.deliveries.index.show')
    end
     
    page.should show_delivery @delivery
  end

  scenario 'commenting on the delivery' do
    visit delivery_path @delivery, :subdomain => @network.subdomain
    
    lambda do
      fill_in 'comment[text]', :with => 'Test Comment'
      click_button 'submit'
    end.should change(@delivery.comments, :count).by(1)
    
    page.should have_notice t('flash.comment_added')

    comment = Comment.last
    comment.user.should == @teacher
    page.should show_comment comment
    page.current_url.should match delivery_path(@delivery)
  end
end
