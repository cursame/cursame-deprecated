class Survey < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner
  include ActiveRecord::Transitions

  default_scope includes(:course).order("due_to DESC")
  has_many   :survey_replies, :dependent => :destroy
  has_many   :questions, :dependent => :destroy, :order => "position ASC"
  belongs_to :course

  validates_presence_of :name, :description, :value, :period, :start_at, :due_to, :course
  validates_inclusion_of :value,  :in => (0..100)
  before_save :start_at_less_than_due_to

  state_machine do
    state :unpublished
    state :published, :enter => :survey_published

    event :publish do
      transitions :to => :published, :from => [:unpublished]
    end
  end

  html_sanitized :description
  # TODO: validate that all survey_answers and associated answers to survey_answers correspond to the same survey
  # TODO: forbid published survey edition at model level
  
  before_create do
    self.start_at ||= DateTime.now
  end
  
  after_save do
    if self.start_at <= DateTime.now and self.unpublished?
      self.publish!
    end
  end

  accepts_nested_attributes_for :questions, :allow_destroy => true 

  def survey_published
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_survey_added'
    end
    emails = course.student_emails
    StudentMailer.delay.new_survey(emails, course, self, course.network) unless emails.blank?
  end

  def expired?
    due_to < DateTime.now
  end
  
  def self.publish_new_surveys
    Survey.unpublished.each do |survey|
      if survey.start_at <= DateTime.now
        survey.publish!
      end
    end
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

  private

  def start_at_less_than_due_to
    if due_to <= start_at
      errors.add(:due_to, I18n.t('.survey.errors.due_to_after_start_at'))
      false
    end

  end
end
