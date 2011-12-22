class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey_reply
  belongs_to :answer, :foreign_key => :answer_uuid, :primary_key => :uuid
  belongs_to :question

  before_validation do
    self.question ||= answer.question
  end
end
