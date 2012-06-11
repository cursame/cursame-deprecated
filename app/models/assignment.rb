class Assignment < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner
  include ActiveRecord::Transitions

  default_scope includes(:course)
  scope :published, where(:state => "published")
  scope :created, where(:state => "created")

  belongs_to :course
  has_many   :deliveries, :dependent => :destroy
  has_many   :comments, :as => :commentable, :dependent => :destroy

  validates_presence_of :name, :description, :value, :period, :due_to, :start_at, :course
  validates_inclusion_of :value,  :in => (0..100)
  validates_inclusion_of :period, :in => (1..8)
  before_save :start_at_less_than_due_to

  state_machine :initial => :created do
    state :created
    state :published, :enter => :notificate_user_about_new_assignment

    event :publish do
      transitions :to => :published, :from => :created
    end
  end

  can_haz_assets

  html_sanitized :description

  before_create do
    self.start_at ||= DateTime.now
  end

  after_create do
    if self.start_at <= DateTime.now
      self.publish!
    end
  end

  after_update do
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_assignment_updated'
    end
  end

  def expired?
    due_to < DateTime.now
  end

  def notificate_user_about_new_assignment
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_assignment_added'
    end
    emails = course.student_emails
    StudentMailer.delay.new_homework(emails, course, course.network) unless emails.blank?
  end

  def self.publish_new_assignments
    Assignment.created.each do |assignment|
      if assignment.start_at <= DateTime.now
        assignment.publish!
      end
    end
  end
  def icon
       'menu-tareas.png'
  end
  private

  def start_at_less_than_due_to
    if due_to <= start_at
      errors.add(:due_to, I18n.t('.assignment.errors.due_to_after_start_at'))
      false
    end
  end
  
end
