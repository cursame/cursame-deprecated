class SurveyReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_one :course, :through => :survey
  has_many :survey_answers

  accepts_nested_attributes_for :survey_answers

  after_create do
    course.teachers.select('users.id').each do |teacher|
      Notification.create :user => teacher, :notificator => self, :kind => 'teacher_survey_replied'
    end
  end
end
