require 'spec_helper'

feature 'Manage assignments', %q{
  In order to let my students assignment work
  As a teacher
  I want use the system to create assignments
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    Enrollment.create(:course => @course, :user => @teacher, :admin => true, :role => 'teacher')
    sign_in_with @teacher, :subdomain => @network.subdomain
    @assignment = Factory(:assignment, :course => @course)
  end

  scenario 'commenting on an assignment' do
    visit assignment_url @assignment, :subdomain => @network.subdomain
    fill_in 'comment[text]', :with => 'Test Comment'
    
    lambda do
      click_button 'submit'
    end.should change(@assignment.comments, :count).by(1)

    page.should have_notice t('flash.comment_added')

    comment = Comment.last
    comment.user.should == @teacher
    page.should show_comment comment
    page.current_url.should match assignment_url(@assignment, :subdomain => @network.subdomain)
  end

  scenario 'removing a posted comment (posted by teacher)' do
    comment    = Factory(:comment, :commentable => @assignment, :user => @teacher)
    visit assignment_url @assignment, :subdomain => @subdomain

    within('.comment:last') do
      lambda do
        click_link t('comments.comments.remove')
      end.should change(@assignment.comments, :count).by(-1)
    end

    page.current_url.should match assignment_url(@assignment, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end

  scenario 'removing a student comment (moderating)' do
    comment    = Factory(:comment, :commentable => @assignment)
    visit assignment_url @assignment, :subdomain => @subdomain

    within('.comment:last') do
      lambda do
        click_link t('comments.comments.remove')
      end.should change(@assignment.comments, :count).by(-1)
    end

    page.current_url.should match assignment_url(@assignment, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end

  scenario 'commenting on an assignment comment' do
    comment    = Factory(:comment, :commentable => @assignment)
    visit assignment_url @assignment, :subdomain => @subdomain

    within('.comment:last') do
      click_link t('comment')
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

  scenario 'not being able to delete an assignment comment if it has comments already' do
    comment = Factory(:comment, :commentable => @assignment, :comments => [Factory(:comment, :user => @teacher)])
    visit assignment_url @assignment, :subdomain => @subdomain
    page.should have_css 'a', :text => t('comments.comments.remove'), :count => 1
    lambda do
      page.driver.delete(comment_url(comment.comments.first, :subdomain => @network.subdomain))
    end.should_not change(@assignment.comments, :count)
  end

  scenario 'cant remove comments from a course that is not mine' do
    pending
  end
end
