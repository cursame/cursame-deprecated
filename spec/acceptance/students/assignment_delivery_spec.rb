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

  scenario 'trying to make a delivery after the assignment is due' do
    Timecop.freeze(Date.today + 30) do
      visit assignment_url @assignment, :subdomain => @network.subdomain
      click_link t('assignments.show.deliver')

      lambda do
        fill_in 'delivery[content]', :with => 'This is my delivery'
        click_button 'submit'
      end.should_not change(Deliver, :count)
    end
  end
end
