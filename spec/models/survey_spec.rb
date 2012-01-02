require 'spec_helper'

describe Survey do
  let(:survey) { Factory.build(:survey) }
  it { survey.valid? or raise survey.errors.inspect }

  describe 'associations' do
    it { should belong_to :course }
    it { should validate_presence_of :course }
    it { should have_many(:questions) }
    it { should have_many(:survey_replies) }
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
    before { survey.description = 'hello<script></script>'}
    it { survey.description.should_not =~ /<script>/ }
    it { survey.description.should be_html_safe }
    it { survey.description.should =~ /hello/}
  end
end
