class Question < ActiveRecord::Base
  belongs_to :survey
  has_many   :answers
  belongs_to :correct_answer, 
    :class_name  => 'Answer', 
    :foreign_key => :answer_uuid, 
    :primary_key => :uuid

  accepts_nested_attributes_for :answers, :allow_destroy => true 

  validates_presence_of :text
  validates_presence_of :correct_answer, :message => "Por favor indique cual es la respuesta correcta"
end
