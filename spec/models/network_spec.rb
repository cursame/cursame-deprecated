require 'spec_helper'

describe Network do
  subject { Factory(:network) }
  it { should have_and_belong_to_many :users }
  it { should have_many :courses }
  # it { should validate_uniqueness_of :subdomain }
end
