require 'spec_helper'

describe Question do
  let(:question) { Factory.build(:question) }
  it { question.valid? or raise question.errors.inspect }
  it { question.save! }

  describe 'validations' do
    it { should validate_presence_of :text }
    it { should validate_presence_of :value }
    it { should validate_presence_of(:correct_answer).with_message(I18n.t('activerecord.errors.question.missing_correct_answer')) }
  end

  describe 'associations' do
    it { should belong_to :survey }
    it { should have_many :answers }
    it { should belong_to :correct_answer }
  end
end
