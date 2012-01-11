class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey_reply
  belongs_to :answer, :foreign_key => :answer_uuid, :primary_key => :uuid
  belongs_to :question

  def correct?
    answer == question.correct_answer
  end 

  def score
    correct? ? question.value : 0
  end

  def state
    correct? ? 'correct' : 'incorrect'
  end
end
