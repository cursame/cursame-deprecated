class Question < ActiveRecord::Base
  belongs_to :survey
  has_many   :answers, :dependent => :destroy, :order => "position ASC"
  belongs_to :correct_answer, 
    :class_name  => 'Answer', 
    :foreign_key => :answer_uuid, 
    :primary_key => :uuid

  accepts_nested_attributes_for :answers, :allow_destroy => true 

  validates_presence_of :text
  validates_presence_of :value
  validates_presence_of :correct_answer, :message => I18n.t('activerecord.errors.question.missing_correct_answer')

  attr_writer :answer_position

  before_validation do
    self.correct_answer = answers.find{ |answer| answer.position == answer_position.to_i }
  end

  def answer_position
    @answer_position ||= correct_answer.try(:position)
  end
end
