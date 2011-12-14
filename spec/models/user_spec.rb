require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_and_belong_to_many :networks }
    it { should have_many(:courses).through(:enrollments) }
    it { should have_many(:assignments).through(:courses) }
    it { should have_many(:manageable_courses).through(:enrollments) }
    it { should have_many(:enrollment_requests).through(:courses) }
    it { should have_many(:manageable_assignments).through(:manageable_courses) }
    it { should have_many(:manageable_discussions) }
    it { should have_many(:discussions).through(:courses) }
    it { should have_many(:comments) }
    it { should have_many(:profile_comments) }
    it { should have_many(:deliveries) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :first_name }
  end
end
