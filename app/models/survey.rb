class Survey < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  default_scope includes(:course)

  belongs_to :course

  validates_presence_of :name, :description, :value, :period, :due_to, :course
  validates_inclusion_of :value,  :in => (0..100)
  validates_inclusion_of :period, :in => (1..8)

  html_sanitized :description

  after_create do
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_survey_added'
    end
  end

  after_update do
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_survey_updated'
    end
  end
end
