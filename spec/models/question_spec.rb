require 'spec_helper'

describe Question do
  it { should validate_presence_of :text }

  describe 'associations' do
    it { should belong_to :survey }
    it { should have_many :answers }
    it { should belong_to :correct_answer }
  end
end
