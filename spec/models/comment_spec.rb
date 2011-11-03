require 'spec_helper'

describe Comment do
  let(:comment) { Factory.build(:comment) }
  it { comment.valid? or raise comment.errors.inspect }

  describe 'associations' do
    it { should belong_to :commentable }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :text }
    it { should validate_presence_of :commentable }
    it { should validate_presence_of :user }
  end

  describe 'html description sanitization' do
    before { comment.text = 'hello<script></script>'}
    it { comment.text.should_not =~ /<script>/ }
    it { comment.text.should be_html_safe }
    it { comment.text.should =~ /hello/}
  end
end
