require 'spec_helper'

describe Discussion do
  let(:discussion) { Factory.build(:discussion) }
  it { discussion.valid? or raise discussion.errors.inspect }

  describe 'associations' do
    it { should belong_to :course }
    it { should have_many :comments }
    it { should validate_presence_of :course }
    it { should have_many :assets }
    it { should belong_to :starter }
  end
  
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :starter }
    it { should validate_presence_of :course }
  end

  describe 'html description sanitization' do
    before { discussion.description = 'hello<script></script>'}
    it { discussion.description.should_not =~ /<script>/ }
    it { discussion.description.should be_html_safe }
    it { discussion.description.should =~ /hello/}
  end
end
