require 'spec_helper'

describe Answer do
  describe 'associations' do
    let(:answer) { Factory.build(:answer) }
    it { answer.id.should be_a String }
    it { answer.id.size.should == 36 }
    it { answer.should be_new_record }
    it { should belong_to :question }
  end
end
