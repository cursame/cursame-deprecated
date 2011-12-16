require 'spec_helper'

describe Question do
  it { should validate_presence_of :text }
  it { should validate_presence_of :correct_answer }

  describe 'associations' do
    it { should belong_to :survey }
    it { should have_many :answers }
    it { should belong_to :correct_answer }
  end
end
