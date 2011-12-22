require 'spec_helper'

describe SurveyReply do
  it { should belong_to :survey }
  it { should belong_to :user }
  it { should have_many :survey_answers }
end
