class SurveyReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_one :course, :through => :survey
  has_many :survey_answers

  accepts_nested_attributes_for :survey_answers

  before_validation do
    unanswered_questions = survey.questions - survey_answers.map(&:question)
    unanswered_questions.each { |question| survey_answers.build :question => question }
  end

  after_create do
    course.teachers.select('users.id').each do |teacher|
      Notification.create :user => teacher, :notificator => self, :kind => 'teacher_survey_replied'
    end
  end
end
