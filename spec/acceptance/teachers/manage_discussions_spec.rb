require 'acceptance/acceptance_helper'

feature 'Manage discussions', %q{
  In order to solve doubts and interact
  As a teacher or students
  I want create and participate in discussions
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :network => @network)
    @course.enrollments.create(:user => @teacher, :admin => true, :role => 'teacher')
    @discussion = Factory(:discussion, :course => @course, :starter => @teacher, :comments => (1..3).map { Factory(:comment, :user => @teacher)})
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'creating a discussion' do
    visit course_discussions_url(@course, :subdomain => @network.subdomain)
    click_link 'new_discussion'

    fill_in 'discussion[title]',       :with => 'Introduction to algebra'
    fill_in 'discussion[description]', :with => 'discussion description'

    lambda do
      click_button 'submit'
    end.should change(Discussion, :count)

    Discussion.should exist_with :title => 'Introduction to algebra', :description => 'discussion description'

    discussion = Discussion.last
    discussion.course.should  == @course
    discussion.starter.should == @teacher
    page.driver.current_url.should match discussion_url(discussion, :subdomain => @network.subdomain)
    page.should have_notice I18n.t('flash.discussion_created')
  end

  scenario 'updating a discussion' do
    visit discussion_url @discussion, :subdomain => @network.subdomain
    
    click_link 'edit_discussion'

    fill_in 'discussion[title]', :with => 'Discussion updated'
    click_button 'submit'
    @discussion.reload
    @discussion.title.should == 'Discussion updated'

    page.driver.current_url.should match discussion_url(@discussion, :subdomain => @network.subdomain)
    page.should have_notice I18n.t('flash.discussion_updated')
  end

  scenario 'viewing a discussion' do
    visit discussion_url(@discussion, :subdomain => @network.subdomain)
    page.should show_discussion @discussion

    @discussion.comments.each do |comment|
      page.should show_comment comment
    end
  end

  scenario 'viewing discussion list' do
    discussions = (1..3).map { Factory(:discussion, :course => @course) }
    (1..2).map { Factory(:discussion) }

    visit course_url(@course, :subdomain => @network.subdomain)
    click_link I18n.t('courses.course_menu.discussions')

    discussions.each do |discussion|
      page.should show_discussion_preview discussion
    end
  end

  scenario 'removing a discussion created by me that has no comments' do
    @discussion.comments = []
    visit discussion_url @discussion, :subdomain => @network.subdomain

    lambda do
      click_link 'remove_discussion'
    end.should change(Discussion, :count).by(-1)

    page.current_url.should match course_discussions_url(@course, :subdomain => @network.subdomain)
    page.should have_notice t('flash.discussion_deleted')
  end

  scenario 'not being able to delete a discussion if it has comments already' do
    visit discussion_url @discussion, :subdomain => @network.subdomain

    page.should_not have_css 'a#remove_discussion'
    
    lambda do
      page.driver.delete(discussion_url(@discussion, :subdomain => @network.subdomain))
    end.should_not change(Discussion, :count)
  end

  scenario 'commenting on a discussion' do
    @discussion.comments = []
    visit discussion_url @discussion, :subdomain => @network.subdomain
    fill_in 'comment[text]', :with => 'Test Comment'
    
    lambda do
      click_button 'submit'
    end.should change(@discussion.comments, :count).by(1)
    
    page.should have_notice t('flash.comment_added')

    comment = Comment.last
    comment.user.should == @teacher
    page.current_url.should match discussion_url(@discussion, :subdomain => @network.subdomain)
    page.should show_comment comment
  end

  scenario 'removing a posted comment from discussion' do
    comment = @discussion.comments.first
    visit discussion_url(@discussion, :subdomain => @network.subdomain)

    within('.comment:first') do
      lambda do
        click_link t('comments.comments.remove')
      end.should change(@discussion.comments, :count).by(-1)
    end

    page.current_url.should match discussion_url(@discussion, :subdomain => @network.subdomain)
    page.should have_notice t('flash.comment_deleted')
  end
end
