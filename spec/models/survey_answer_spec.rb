require 'spec_helper'

describe SurveyAnswer do
  it { should belong_to :survey_reply }
  it { should belong_to :answer }
end
