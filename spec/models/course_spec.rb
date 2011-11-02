require 'spec_helper'

describe Course do
  it { should have_many(:teachers).through(:assignations) }
  it { should have_many(:course_assets) }
  it { should belong_to :network }

  it { should validate_presence_of :network }

  describe 'assignation and teachers' do
    let(:teacher) { Factory(:teacher) }

    it 'should build and save asignation' do
      course = Factory.build(:course)
      course.assignations.build(:user => teacher, :admin => true)
      lambda { course.save }.should change(Assignation, :count).by(1)
    end
  end
end