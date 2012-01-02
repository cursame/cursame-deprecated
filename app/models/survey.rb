class Survey < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  default_scope includes(:course)
  has_many   :survey_replies
  belongs_to :course

  validates_presence_of :name, :description, :value, :period, :due_to, :course
  validates_inclusion_of :value,  :in => (0..100)
  validates_inclusion_of :period, :in => (1..8)

  html_sanitized :description
  # TODO: validate that all survey_answers and associated answers to survey_answers correspond to the same survey

  has_many :questions
  accepts_nested_attributes_for :questions, :allow_destroy => true 

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

  def expired?
    @survey.due_to < DateTime.now
  end
end
