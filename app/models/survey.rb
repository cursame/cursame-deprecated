class Survey < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner
  include ActiveRecord::Transitions

  default_scope includes(:course).order("due_to DESC")
  has_many   :survey_replies
  belongs_to :course

  validates_presence_of :name, :description, :value, :period, :due_to, :course
  validates_inclusion_of :value,  :in => (0..100)
  validates_inclusion_of :period, :in => (1..8)

  state_machine do
    state :unpublished
    state :published, :enter => :survey_published

    event :publish do
      transitions :to => :published, :from => :unpublished
    end
  end

  html_sanitized :description
  # TODO: validate that all survey_answers and associated answers to survey_answers correspond to the same survey
  # TODO: forbid published survey edition at model level

  has_many :questions
  accepts_nested_attributes_for :questions, :allow_destroy => true 

  def survey_published
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
    due_to < DateTime.now
  end

  class << self
    def published
      where(:state => :published)
    end

    def unpublished
      where(:state => :unpublished)
    end

    def all_states
      where(:state => "*")
    end
  end
end
