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
    @discussion = Factory(:discussion, :course => @course, :comments => (1..3).map { Factory(:comment, :user => @teacher)})
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'creating a discussion' do
    pending
    visit course_url(@course, :subdomain => @network.subdomain)
    click_link I18n.t('courses.show.create_discussion')

    fill_in 'discussion[name]',        :with => 'Introduction to algebra'
    fill_in 'discussion[description]', :with => 'discussion description'

    lambda do
      click_button 'submit'
    end.should change(Discussion, :count)

    Discussion.should exist_with :name => 'Introduction to algebra', :name => 'Introduction to algebra',

    discussion = Discussion.last
    discussion.course.should == @course
    page.driver.current_url.should ~= discussion_path(discussion)
    page.should have_notice I18n.t('flash.discussion_created')
  end

  scenario 'updating a discussion' do
    pending
    visit edit_discussion_url @discussion, :subdomain => @network.subdomain
    fill_in 'discussion[name]', :with => 'Discussion updated'
    click_button 'submit'
    @discussion.reload
    @discussion.name.should == 'Discussion updated'
  end

  scenario 'viewing a discussion' do
    pending
    visit discussion_url(@discussion, :subdomain => @network.subdomain)
    page.should show_discussion @discussion

    @discussion.comments.each do |comment|
      page.should show_comment comment
    end
  end

  scenario 'viewing discussion list' do
    pending
    discussions = (1..3).map { Factory(:discussion, :course => @course) }
    (1..2).map { Factory(:discussion) }
    visit discussions_path

    discussions.each do |discussion|
      page.should show_discussion_preview discussion
    end
  end

  scenario 'commenting on a discussion' do
    pending
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
    pending
    comment = Factory(:comment, :commentable => @discussion, :user => @teacher)
    visit discussion_url @discussion, :subdomain => @network.subdomain

    within('.comment:last') do
      lambda do
        click_link t('comments.comments.remove')
      end.should change(@discussion.comments, :count).by(-1)
    end

    page.current_url.should match discussion_url(@discussion, :subdomain => @network.subdomain)
    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end
end
