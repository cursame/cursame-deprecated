shared_examples_for 'has basic actions for assignments' do
  scenario 'viewing a list of assignments' do
    assignments = (1..3).map { Factory(:assignment, :course => @course) }
    visit course_assignments_path @course
    assignments.each do |assignment|
      page.should show_assignment_preview assignment
    end
  end

  scenario 'commenting on an assignment' do
    pending
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
end
