require 'spec_helper'

describe SurveyReply do
  let(:survey_reply) { Factory.build(:survey_reply) }
  it { survey_reply.valid? or raise survey_reply.errors.inspect }

  it { should belong_to :survey }
  it { should belong_to :user }
  it { should have_many :survey_answers }
end
