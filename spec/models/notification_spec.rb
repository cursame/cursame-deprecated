require 'spec_helper'

describe Notification do 
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :notificator }
  end

  describe Enrollment do
    before do
      @teacher = Factory(:teacher)
      @user    = Factory(:student)
      @course  = Factory(:course)
      lambda { Factory(:teacher_enrollment, :user => @teacher, :course => @course) }.should_not change(Notification, :count)
      lambda do
        @enrollment = Factory(:student_enrollment, :user => @teacher, :course => @course)
      end.should change(Notification, :count).by(1)
      @notification = Notification.last
    end

    it { @notification.kind.should        == 'student_course_enrollment' }
    it { @notification.user.should        == @teacher }
    it { @notification.notificator.should == @enrollment }
  end
end
