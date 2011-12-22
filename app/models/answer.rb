class Answer < ActiveRecord::Base
  set_primary_key :uuid

  belongs_to :question
  has_many   :survey_answers

  after_initialize do |answer|
    answer.uuid ||= UUID.new.generate
  end

  validates_presence_of :text, :position
  validates_uniqueness_of :position, :scope => :question_id
end
