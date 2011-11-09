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

  scenario 'removing a posted comment from the wall (owned by teacher)' do
    comment = Factory(:comment, :commentable => @course, :user => @teacher)
    visit wall_for_course_url @course, :subdomain => @network.subdomain

    lambda do
      click_link t('comments.comments.remove')
    end.should change(@course.comments, :count).by(-1)

    page.current_url.should match wall_for_course_url(@course, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end
  
  scenario 'removing a posted comment from the wall (not owned by teacher)' do
    comment = Factory(:comment, :commentable => @course, :user => Factory(:user))
    visit wall_for_course_url @course, :subdomain => @network.subdomain

    lambda do
      click_link t('comments.comments.remove')
    end.should change(@course.comments, :count).by(-1)

    page.current_url.should match wall_for_course_url(@course, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end

  scenario 'commenting on an wall comment' do
    comment    = Factory(:comment, :commentable => @course)
    visit wall_for_course_url @course, :subdomain => @network.subdomain

    within('.comments .comment:last') do
      # click_link t('comment')
      fill_in 'comment[text]', :with => 'Comment of a comment'
      lambda do
        click_button 'submit'
      end.should change(comment.comments, :count).by(1)
    end

    comments_comment = Comment.last
    comments_comment.commentable.should == comment

    page.should show_comment comments_comment
    page.should have_notice t('flash.comment_added')
  end
end
