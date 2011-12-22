class SubmittedQuestion < ActiveRecord::Base
  belongs_to :submitted_survey
  belongs_to :question
  #belongs_to :answer
  #belongs_to :user, :through => :submitted_survey
  validates_presence_of :answer_uuid, :message => "Por favor seleccione una respuesta"
end
