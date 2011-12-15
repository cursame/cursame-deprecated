class Answer < ActiveRecord::Base
  belongs_to :question
  attr_protected :id

  after_initialize do |answer|
    answer.id ||= UUID.new.generate
  end
end
