require 'spec_helper'

describe User do

  it { should have_and_belong_to_many :networks }
  it { should have_many(:lectures).through(:assignations) }

end
