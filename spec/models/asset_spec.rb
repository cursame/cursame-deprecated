require 'spec_helper'

describe Asset do
  include CarrierWave::Test::Matchers
  it { should belong_to :owner }
end
