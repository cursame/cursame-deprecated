require 'acceptance/acceptance_helper'

feature 'Manage assignments', %q{
  In order to let my students assignment work
  As a teacher
  I want use the system to create assignments
} do

  background do
    @network = Factory(:network)
    @teacher = Factory(:teacher, :networks => [@network])
    @course  = Factory(:course, :teachers => [@teacher], :network => @network)
    sign_in_with @teacher, :subdomain => @network.subdomain
  end

  scenario 'creating an assignment' do
    visit course_url(@course, :subdomain => @network.subdomain)
    click_link 'new_assignment'
    fill_in 'assignment[name]',        :with => 'First assignment'
    fill_in 'assignment[description]', :with => 'This is a test assignment'
    fill_in 'assignment[value]',       :with => 9
    fill_in 'assignment[period]',      :with => 1

    # TODO: we need a select_date helper
    select '2011',    :from => 'assignment[due_to(1i)]'
    select 'enero',   :from => 'assignment[due_to(2i)]'
    select '20',      :from => 'assignment[due_to(3i)]'
    select '8',       :from => 'assignment[due_to(4i)]'
    select '30',      :from => 'assignment[due_to(5i)]'

    lambda do
      click_button 'submit'
    end.should change(Assignment, :count).by(1)

    expected_attrs = {
      :name => 'First assignment', 
      :description => 'This is a test assignment', 
      :value => 9, 
      :period => 1,
      # :due_to => Time.new(2011,1,20,8,30)
    }

    Assignment.should exist_with expected_attrs
    assignment = Assignment.last

    assignment.course.should == @course

    page.current_url.should match assignment_path(assignment)
    page.should show_assignment assignment
    page.should have_notice t('flash.assignment_created')
  end

  scenario 'commenting on an assignment' do
    assignment = Factory(:assignment, :course => @course)
    visit assignment_url assignment, :subdomain => @subdomain

    fill_in 'comment[text]', :with => '<p>Just testing the comments</p>'
    
    lambda do
      click_button 'comment'
    end.should change(assignment, :comments).by(1)

    comment = Comment.last
    comment.text.should == '<p>Just testing the comments</p>'

    page.should show_comment comment
    page.should have_notice t('flash.assignment_created')
  end

  scenario 'commenting on an assignment comment' do
    pending
    assignment = Factory(:assignment)
    comment    = Factory(:comment, :commentable => assignment)
    visit assignment_url assignment, :subdomain => @subdomain

    within('#root_comments .comment:last') do
      fill_in 'comment[text]', :with => '<p>Comment of a comment</p>'
      lambda do
        click_button 'comment'
      end.should change(assignment, :comments).by(1)
    end

    comments_comment = Comment.last
    comments_comment.text.should == '<p>Comment of a comment</p>'
    comments_comment.commentable.should == comment

    within('#root_comments .comment:last') do
      page.should show_comment comments_comment
    end
    page.should have_notice t('flash.comment_created')
  end

  scenario 'removing an assignment comment' do
    pending
    assignment = Factory(:assignment)
    comment    = Factory(:comment, :commentable => assignment)
    visit assignment_url assignment, :subdomain => @subdomain

    within('#root_comments .comment:last') do
      lambda do
        click_link t('remove')
      end.should change(assignment, :comments).by(-1)
    end

    page.should_not show_comment comment
    page.should have_notice t('flash.comment_deleted')
  end

  scenario 'not being able to delete an assignment comment if it has comments already' do
    pending
    assignment = Factory(:assignment)
    comment    = Factory(:comment, :commentable => assignment)
    visit assignment_url assignment, :subdomain => @subdomain

    within('#root_comments .comment:last') do
      page.should_not have_css 'a'
    end

    lambda do
      page.driver.delete(delete_comment_url(comment, :subdomain => @network.subdomain))
    end.should_not change(assignment.comments, :count)
  end

  scenario 'cant remove comments from a course that is not mine' do
    pending
  end
end
