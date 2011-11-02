require 'spec_helper'

describe Comment do
  let(:comment) { Factory.build(:comment) }

  it { comment.should be_valid }
  it { should belong_to :commentable }
  it { should validate_prescence_of :text }

  describe 'html description sanitization' do
    before { comment.text = 'hello<script></script>'}
    it { comment.text.should_not =~ /<script>/ }
    it { comment.text.should be_html_safe }
    it { comment.text.should =~ /hello/}
  end
end
