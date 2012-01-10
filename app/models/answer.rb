class Answer < ActiveRecord::Base
  set_primary_key :uuid

  belongs_to :question
  has_many   :survey_answers

  validates_presence_of :text, :position, :uuid
  validates_uniqueness_of :uuid
  attr_accessible :position, :text, :_destroy, :uuid
  # TODO: validate uuid not changed and uuid format
end
