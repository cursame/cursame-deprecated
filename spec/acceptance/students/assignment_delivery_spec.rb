require 'acceptance/acceptance_helper'

feature 'Manage assignments', %q{
  In order to accomplish my course work
  As a student
  I want to complete assignments
} do

  background do
    @network    = Factory(:network)
    @user       = Factory(:user, :networks => [@network])
    @course     = Factory(:course,  :network => @network)
    @assignment = Factory(:assignment, :course => @course)
    Enrollment.create(:course => @course, :user => @user, :admin => false, :role => 'student', :state => 'accepted')
    sign_in_with @user, :subdomain => @network.subdomain
  end

  scenario 'making a delivery for an assignment' do
    visit assignment_url @assignment, :subdomain => @network.subdomain
    click_link t('assignments.show.deliver')

    page.should_not link_to assignment_delivery_path(@assignment)
    page.should_not link_to edit_assignment_delivery_path(@assignment)

    lambda do
      fill_in 'delivery[content]', :with => 'This is my delivery'
      click_button 'submit'
    end.should change(Delivery, :count).by(1)

    Delivery.should exist_with :content => ActiveRecord::HTMLSanitization.sanitize('This is my delivery'), 
                               :user_id => @user.id, :assignment_id => @assignment.id
    page.should have_notice t('flash.delivery_created')
    page.should show_delivery Delivery.last
  end

  scenario 'editing a delivery for an assignment' do
    Factory(:delivery, :assignment => @assignment, :user => @user)
    visit assignment_url @assignment, :subdomain => @network.subdomain
    click_link t('assignments.show.edit_delivery')

    lambda do
      fill_in 'delivery[content]', :with => 'This is my edited delivery'
      click_button 'submit'
    end.should_not change(Delivery, :count)

    Delivery.should exist_with :content => ActiveRecord::HTMLSanitization.sanitize('This is my edited delivery'), 
                               :user_id => @user.id, :assignment_id => @assignment.id
    page.should have_notice t('flash.delivery_updated')
    page.should show_delivery Delivery.last
  end

  scenario 'viewing a delivery for an assignment' do
    delivery = Factory(:delivery, :assignment => @assignment, :user => @user)
    visit assignment_url @assignment, :subdomain => @network.subdomain

    page.should_not link_to new_assignment_delivery_path(@assignment)

    click_link t('assignments.show.show_delivery')

    page.should show_delivery delivery
  end

  scenario 'trying to make a delivery after the assignment is due' do
    Timecop.freeze(6.months.from_now) do
      visit assignment_url @assignment, :subdomain => @network.subdomain

      page.should_not link_to assignment_delivery_path(@assignment)
      page.should_not link_to edit_assignment_delivery_path(@assignment)
      page.should_not link_to new_assignment_delivery_path(@assignment)
      
      page.should have_content t('assignments.show.failed_delivery')

      lambda do
        page.driver.post assignment_delivery_path(@assignment), :delivery => {:content => 'nay nay!'}
      end.should_not change(Delivery, :count)
    end
  end

  scenario 'trying to make a delivery when I did one already' do
    Factory(:delivery, :assignment => @assignment, :user => @user)
    visit assignment_url @assignment, :subdomain => @network.subdomain

    page.should     link_to assignment_delivery_path(@assignment)
    page.should     link_to edit_assignment_delivery_path(@assignment)
    page.should_not link_to new_assignment_delivery_path(@assignment)

    lambda do
      page.driver.post assignment_delivery_path(@assignment), :delivery => {:content => 'nay nay!'}
    end.should_not change(Delivery, :count)
  end

  scenario 'commenting on the delivery' do
    delivery = Factory(:delivery, :assignment => @assignment, :user => @user)
    visit assignment_delivery_path @assignment, :subdomain => @network.subdomain
    
    lambda do
      fill_in 'comment[text]', :with => 'Test Comment'
      click_button 'submit'
    end.should change(delivery.comments, :count).by(1)
    
    page.should have_notice t('flash.comment_added')

    comment = Comment.last
    comment.user.should == @user
    page.should show_comment comment
    page.current_url.should match assignment_delivery_path(@assignment)
  end
end
