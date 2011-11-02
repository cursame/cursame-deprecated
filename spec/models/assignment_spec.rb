require 'spec_helper'

describe Assignment do
  let(:assignment) { Factory.build(:assignment) }
  it { assignment.valid? or raise assignment.errors.inspect }

  describe 'associations' do
    it { should belong_to :course }
    it { should have_many :comments }
    it { should validate_presence_of :course }
  end
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :value }
    it { should ensure_inclusion_of(:value).in_range(0..100) }
    it { should validate_presence_of :period }
    it { should ensure_inclusion_of(:period).in_range(1..8) }
    it { should validate_presence_of :due_to }
  end

  describe 'html description sanitization' do
    before { assignment.description = 'hello<script></script>'}
    it { assignment.description.should_not =~ /<script>/ }
    it { assignment.description.should be_html_safe }
    it { assignment.description.should =~ /hello/}
  end
end
