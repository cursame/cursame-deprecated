require 'spec_helper'

describe Course do
  it { should have_many(:teachers).through(:assignations) }
end
