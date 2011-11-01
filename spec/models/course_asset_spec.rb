require 'spec_helper'

describe CourseAsset do
  include CarrierWave::Test::Matchers
  it { should belong_to :course }
end
