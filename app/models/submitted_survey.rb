class SubmittedSurvey < ActiveRecord::Base
  belongs_to :survey
  belongs_to :user

  has_many :submitted_questions
  accepts_nested_attributes_for :submitted_questions, :allow_destroy => true
end
