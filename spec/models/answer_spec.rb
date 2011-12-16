require 'spec_helper'

describe Answer do
  it { should validate_presence_of :text }

  describe 'associations' do
    let(:answer) { Factory.build(:answer) }
    it { answer.valid? or raise answer.errors.inspect }

    describe 'uuid' do
      it { answer.uuid.should be_a String }
      it { answer.uuid.size.should == 36 }
      it { answer.should be_new_record }
    end

    it { should belong_to :question }
  end
end
