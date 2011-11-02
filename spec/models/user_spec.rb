require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_and_belong_to_many :networks }
    it { should have_many(:lectures).through(:assignations) }
    it { should have_many(:courses).through(:enrollments) }
    it { should have_many(:assignments).through(:courses) }
  end
end
