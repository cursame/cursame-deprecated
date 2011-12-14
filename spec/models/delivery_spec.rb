require 'spec_helper'

describe Delivery do
  let(:delivery) { Factory.build(:delivery) }
  it { delivery.valid? or raise delivery.errors.inspect }

  describe 'associations' do
    it { should belong_to :assignment }
    it { should validate_presence_of :assignment }
    it { should have_many :comments }
    it { should have_many :assets }
    it { should belong_to :user }
  end

  describe 'html content sanitization' do
    before { delivery.content = 'hello<script></script>'}
    it { delivery.content.should_not =~ /<script>/ }
    it { delivery.content.should be_html_safe }
    it { delivery.content.should =~ /hello/}
  end
end
