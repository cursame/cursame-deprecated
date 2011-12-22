class Question < ActiveRecord::Base
  belongs_to :survey
  has_many   :answers, :order => "'index' ASC"
  belongs_to :correct_answer, 
    :class_name  => 'Answer', 
    :foreign_key => :answer_uuid, 
    :primary_key => :uuid

  accepts_nested_attributes_for :answers, :allow_destroy => true 

  validates_presence_of :text
  validates_presence_of :correct_answer, :message => I18n.t('activerecord.errors.question.missing_correct_answer')

  attr_writer :answer_index

  before_validation do
    self.correct_answer = answers.find{ |answer| answer.index == answer_index.to_i }
  end

  def answer_index
    @answer_index ||= correct_answer.try(:index)
  end
end
