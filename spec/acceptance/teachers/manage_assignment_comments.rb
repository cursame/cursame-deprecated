require 'acceptance/acceptance_helper'

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
    visit assignment_url @assignment, :subdomain => @subdomain
    fill_in 'comment[text]', :with => 'Test Comment'
    
    lambda do
      click_button 'submit'
    end.should change(@assignment.comments, :count).by(1)

    page.should have_notice t('flash.comment_added')

    comment = Comment.last
    comment.user.should == @teacher
    within("#comment_#{comment.id}") do
      page.should have_content 'Test Comment'
    end
    page.current_url.should match assignment_url(@assignment, :subdomain => @network.subdomain)
  end

  # scenario 'commenting on an assignment comment' do
  #   pending
  # end

  scenario 'removing an assignment comment' do
    pending
    comment    = Factory(:comment, :commentable => @assignment)
    visit assignment_url @assignment, :subdomain => @subdomain

    within('#root_comments .comment:last') do
      lambda do
        click_link t('remove')
      end.should change(@assignment.comments, :count).by(-1)
    end

    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end

  scenario 'not being able to delete an assignment comment if it has comments already' do
    pending
    comment    = Factory(:comment, :commentable => @assignment)
    visit assignment_url @assignment, :subdomain => @subdomain

    within('#root_comments .comment:last') do
      page.should_not have_css 'a'
    end

    lambda do
      page.driver.delete(delete_comment_url(comment, :subdomain => @network.subdomain))
    end.should_not change(@assignment.comments, :count)
  end

  scenario 'cant remove comments from a course that is not mine' do
    pending
  end
end
