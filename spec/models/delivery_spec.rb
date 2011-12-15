require 'spec_helper'

describe Delivery do
  let(:delivery) { Factory.build(:delivery) }
  it { delivery.valid? or raise delivery.errors.inspect }

  describe 'associations' do
    it { should belong_to :assignment }
    it { should have_many :comments }
    it { should have_many :assets }
    it { should belong_to :user }
  end

  describe 'validations' do
    it 'should not allow delivery when date is due' do
      delivery.should be_valid
      Timecop.freeze(6.month.from_now) do
        delivery.should_not be_valid
        delivery.errors[:base].should include('Due date has passed')
      end
    end

    describe 'two deliveries for the same assignment attempt' do
      before do
        delivery.save!
        @second_delivery = Factory.build(:delivery, :user => delivery.user, :assignment => delivery.assignment)
        @others_deliver  = Factory.build(:delivery, :assignment => delivery.assignment)
      end

      it { @second_delivery.should_not be_valid }
      it { @others_deliver.should be_valid }
    end
  end

  describe 'html content sanitization' do
    before { delivery.content = 'hello<script></script>'}
    it { delivery.content.should_not =~ /<script>/ }
    it { delivery.content.should be_html_safe }
    it { delivery.content.should =~ /hello/}
  end
end
