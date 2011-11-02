require 'spec_helper'

describe Enrollment do
  it { should belong_to :user }
  it { should belong_to :course }
end
