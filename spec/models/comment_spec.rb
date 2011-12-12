require 'spec_helper'

describe Comment do
  let(:comment) { Factory.build(:comment) }
  it { comment.valid? or raise comment.errors.inspect }

  describe 'associations' do
    it { should belong_to :commentable }
    it { should belong_to :user }
    it { should have_many :comments }
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

  describe 'autolink' do
    it 'should autolink image' do
      comment.text = 'http://rors.org/images/rails.png'
      comment.text.should == '<img src="http://rors.org/images/rails.png" alt=""/>'
    end

    it 'should autolink youtube' do
      comment.text = 'http://www.youtube.com/watch?v=BwNrmYRiX_o'
      comment.text.should == '<iframe width="400" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen></iframe>'
    end
  end
end
