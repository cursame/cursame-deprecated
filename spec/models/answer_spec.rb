require 'spec_helper'

describe Answer do
  describe 'associations' do
    it { should belong_to :question }
  end
end
