require 'acceptance/acceptance_helper'

feature 'Manage profile wall', %q{
  In order to socialize
  As a teacher or student
  I want participate in my wall and others wall
} do

  background do
    @network = Factory(:network)
    @user    = Factory(:user, :networks => [@network])
    @course  = Factory(:course,  :network => @network)
    Enrollment.create(:course => @course, :user => @user, :admin => false, :role => 'student', :state => 'accepted')
    sign_in_with @user, :subdomain => @network.subdomain
  end

  scenario 'commenting on the wall' do
    visit wall_for_user_url @user, :subdomain => @network.subdomain
    fill_in 'comment[text]', :with => 'Test Comment'
    
    lambda do
      click_button 'submit'
    end.should change(@user.profile_comments, :count).by(1)
    
    page.should have_notice t('flash.comment_added')

    comment = Comment.last
    comment.user.should == @user
    page.should show_comment comment
    page.current_url.should match wall_for_user_url(@user, :subdomain => @network.subdomain)
  end

  scenario 'removing a posted comment from the wall (owned by self)' do
    comment = Factory(:comment, :commentable => @user, :user => @user)
    visit wall_for_user_url @user, :subdomain => @network.subdomain

    lambda do
      click_link t('comments.comments.remove')
    end.should change(@user.profile_comments, :count).by(-1)

    page.current_url.should match wall_for_user_url(@user, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end
  
  scenario 'removing a posted comment from the wall (owned by other)' do
    comment = Factory(:comment, :commentable => @user, :user => Factory(:user))
    visit wall_for_user_url @user, :subdomain => @network.subdomain

    lambda do
      click_link t('comments.comments.remove')
    end.should change(@user.profile_comments, :count).by(-1)

    page.current_url.should match wall_for_user_url(@user, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end

  scenario 'commenting on an wall comment' do
    comment    = Factory(:comment, :commentable => @user)
    visit wall_for_user_url @user, :subdomain => @network.subdomain

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

  scenario 'viewing other user wall' do
    @user2  = Factory(:user, :networks => [@network])
    comment = Factory(:comment, :commentable => @user2)
    visit wall_for_user_url @user2, :subdomain => @network.subdomain
    page.should show_comment comment
  end
end
