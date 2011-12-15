class Question < ActiveRecord::Base
  belongs_to :survey
  has_many   :answers
  belongs_to :correct_answer, :class_name => 'Answer', :foreign_key => :answer_id

  accepts_nested_attributes_for :answers, 
    :allow_destroy => true, 
    :reject_if => lambda { |hash| hash[:text].blank? }
end
