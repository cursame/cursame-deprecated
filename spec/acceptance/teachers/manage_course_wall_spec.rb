require 'acceptance/acceptance_helper'

feature 'Manage course wall', %q{
  In order to socialize
  As a teacher or student
  I want participate in the wall
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    Enrollment.create(:course => @course, :user => @teacher, :admin => true, :role => 'teacher')
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'commenting on the wall' do
    visit wall_for_course_url @course, :subdomain => @network.subdomain
    fill_in 'comment[text]', :with => 'Test Comment'
    
    lambda do
      click_button 'submit'
    end.should change(@course.comments, :count).by(1)
    
    page.should have_notice t('flash.comment_added')

    comment = Comment.last
    comment.user.should == @teacher
    page.should show_comment comment
    page.current_url.should match wall_for_course_url(@course, :subdomain => @network.subdomain)
  end

  scenario 'removing a posted comment from the wall' do
    comment = Factory(:comment, :commentable => @course, :user => @teacher)
    visit wall_for_course_url @course, :subdomain => @network.subdomain

    save_and_open_page
    within('.comment:last') do
      lambda do
        click_link t('comments.comments.remove')
      end.should change(@course.comments, :count).by(-1)
    end

    page.current_url.should match wall_for_course_url(@course, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end
end
