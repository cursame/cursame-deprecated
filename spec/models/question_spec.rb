require 'spec_helper'

describe Question do
  describe 'associations' do
    it { should belong_to :survey }
    it { should have_many :answers }
    it { should belong_to :correct_answer }
  end
end
