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

  describe 'html processing' do
    describe 'sanitization' do
      before { comment.text = 'hello<script></script>'}
      it { comment.text.should_not =~ /<script>/ }
      it { comment.text.should be_html_safe }
      it { comment.text.should =~ /hello/}
    end

    it 'should insert line breaks' do
      comment.text = "hello\ngoodbye"
      comment.text.should == "<p>hello\n<br />goodbye</p>"
    end

    describe 'autolink' do
      it 'should autolink image' do
        comment.text = 'http://rors.org/images/rails.png'
        comment.text.should == '<p><img src="http://rors.org/images/rails.png" alt=""/></p>'
      end

      it 'should autolink youtube' do
        comment.text = 'http://www.youtube.com/watch?v=BwNrmYRiX_o'
        comment.text.should == '<p><iframe width="400" height="250" src="http://www.youtube.com/embed/BwNrmYRiX_o?wmode=transparent" frameborder="0" allowfullscreen></iframe></p>'
      end
    end
  end
end
