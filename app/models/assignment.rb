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

  validates_presence_of :name, :description, :value, :period, :due_to, :course
  validates_inclusion_of :value,  :in => (0..100)
  validates_inclusion_of :period, :in => (1..8)
  
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
      self.publish
      self.update_attribute(:state, "published")
    end
  end
  
  after_update do
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_assignment_updated'
    end
  end
  
  def notificate_user_about_new_assignment
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_assignment_added'
    end
    if course.students.count > 0 and !course.all_emails(nil).blank?
      StudentMailer.delay.new_homework(course.students, course, course.network)
    end
  end
  
  def self.publish_new_assignments
    Assignment.created.each do |assignment|
      if assignment.start_at <= DateTime.now
        assignment.publish 
        assignment.update_attribute(:state, "published")
      end
    end
  end
  
end
