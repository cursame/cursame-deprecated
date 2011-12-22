require 'spec_helper'

describe Notification do 
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :notificator }
  end
end
