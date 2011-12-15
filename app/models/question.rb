class Question < ActiveRecord::Base
  belongs_to :survey
  has_many   :answers
  belongs_to :correct_answer, :class_name => 'Answer', :foreign_key => :answer_id
end
