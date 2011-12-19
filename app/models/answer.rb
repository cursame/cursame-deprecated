class Answer < ActiveRecord::Base
  belongs_to :question

  after_initialize do |answer|
    answer.uuid ||= UUID.new.generate
  end

  before_save do
    is_correct = question.correct_answer == self
    unless /[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/ === uuid.to_s
      self.uuid = UUID.new.generate
      question.update_attribute :answer_uuid, self.uuid if is_correct
    end
  end

  validates_presence_of :text
end
