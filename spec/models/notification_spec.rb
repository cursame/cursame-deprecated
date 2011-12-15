require 'spec_helper'

describe Notification do 
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :notificator }
  end
  # describe 'triggering' do
  #   before do
  #     @teacher = Factory(:teacher)
  #     @user    = Factory(:student)
  #     @course  = Factory(:course)
  #     lambda do
  #       Factory(:teacher_enrollment, :user => @teacher, :course => @course)
  #     end.should_not change(Notification, :count)
  #     lambda do
  #       @enrollment = Factory(:student_enrollment, :user => @teacher, :course => @course)
  #     end.should change(Notification, :count).by(1)
  #   end

  #   describe 'for teacher when student wants to enrole' do
  #     before do
  #       @notification = Notification.last
  #     end

  #     it { @notification.kind.should        == 'student_course_enrollment' }
  #     it { @notification.user.should        == @teacher }
  #     it { @notification.notificator.should == @enrollment }
  #   end

  #   describe 'for teacher when student delivers' do
  #     before do
  #       assignment = Factory(:assignment, :course => @course) 
  #       lambda do
  #         @delivery = Factory(:delivery, :assignment => assignment, :user => @student)
  #       end.should change(Notification, :count).by(1)
  #       @notification = Notification.last
  #     end

  #     it { @notification.kind.should        == 'student_assignment_delivery' }
  #     it { @notification.user.should        == @teacher }
  #     it { @notification.notificator.should == @delivery }
  #   end

  #   describe 'for student when teacher rejects' do
  #     before do
  #       lambda { @enrollment.reject! }.should change(Notification, :count)
  #     end

  #     it { @notification.kind.should        == 'student_course_rejected' }
  #     it { @notification.user.should        == @student }
  #     it { @notification.notificator.should == @enrollment }
  #   end
  # end
end
