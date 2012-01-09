require 'spec_helper'

describe Answer do
  let(:answer) { Factory.build(:answer) }
  it { answer.valid? or raise answer.errors.inspect }

  describe 'validations' do
    it { should validate_presence_of :text }
    it { should validate_presence_of :position }
  end

  describe 'associations' do
    it { should belong_to :question }
  end

  describe 'uuid' do
    it { answer.uuid.should be_a String }
    it { answer.uuid.size.should == 36 }
    it { answer.should be_new_record }
  end
end
