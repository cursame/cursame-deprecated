require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_and_belong_to_many :networks }
    it { should have_many(:courses).through(:enrollments) }
    it { should have_many(:assignments).through(:courses) }
    it { should have_many(:manageable_courses).through(:enrollments) }
    it { should have_many(:enrollment_requests).through(:courses) }
  end
end
