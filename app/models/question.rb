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

  validate do
    errors.add(:answer_uuid, I18n.t('activerecord.errors.question.missing_correct_answer')) if answer_uuid.blank?
  end
end
