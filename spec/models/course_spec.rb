require 'spec_helper'

describe Course do
  describe 'associations' do
    it { should have_many(:assets) }
    it { should belong_to :network }
    it { should have_many :assignments }
    it { should have_many(:teachers).through(:enrollments) }
    it { should have_many(:students).through(:enrollments) }
    it { should have_many(:users).through(:enrollments) }

    describe '#users' do
      it 'does not include rejected users' do
        course = Factory(:course)
        course.enrollments.create(:user => Factory(:student), :state => 'accepted', :role => 'student')
        course.enrollments.create(:user => Factory(:student), :state => 'accepted', :role => 'student')
        course.enrollments.create(:user => Factory(:student), :state => 'rejected', :role => 'student')

        course.users.count.should == 2
      end
    end
  end

  describe 'validations' do
    it { should validate_presence_of :network }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :finish_date }
  end

  describe 'html description sanitization' do
    let(:course) { Factory(:course, :description => '<script>pure evil</script>')}
    it { course.description.should_not =~ /<script>/ }
    it { course.description.should be_html_safe }
  end

  describe 'enrolments and roles'
end
