class SurveyReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_one :course, :through => :survey
  has_many :survey_answers

  accepts_nested_attributes_for :survey_answers
  validates_uniqueness_of :survey_id, :scope => :user_id

  # TODO: validate that each survey.question has a survey_answer and each survey_answer corresponds to a survey.question
  
  validate do
    errors.add(:base, 'Due date has passed') if survey.due_to < DateTime.now
  end

  after_create do
    course.teachers.select('users.id').each do |teacher|
      Notification.create :user => teacher, :notificator => self, :kind => 'teacher_survey_replied'
    end
  end

  after_update do
    course.teachers.select('users.id').each do |teacher|
      Notification.create :user => teacher, :notificator => self, :kind => 'teacher_survey_updated'
    end
  end

  def score
    total  = survey.questions.reduce(0) { |sum, question| sum + question.value }
    scored = survey_answers.reduce(0) { |sum, answer| sum + answer.score }
    10.0 * scored / total
  end
end
