require 'spec_helper'

describe Assignment do
  let(:assignment) { Factory.build(:assignment) }

  it { assignment.should be_valid }
  it { should belong_to :course }
  it { should have_many :comments }
  
  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :value }
    it { should ensure_inclusion_of(:value).in_range(0..100) }
    it { should validate_presence_of :period }
    it { should ensure_inclusion_of(:period).in_range(1..8) }
    it { should validate_presence_of :due_to }
  end
end
