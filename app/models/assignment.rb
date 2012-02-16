class Assignment < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  default_scope includes(:course)

  belongs_to :course
  has_many   :deliveries, :dependent => :destroy
  has_many   :comments, :as => :commentable, :dependent => :destroy

  validates_presence_of :name, :description, :value, :period, :due_to, :course
  validates_inclusion_of :value,  :in => (0..100)
  validates_inclusion_of :period, :in => (1..8)

  can_haz_assets

  html_sanitized :description
  
  after_create do
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_assignment_added'
    end
    StudentMailer.new_homework(course.students, course, course.network).deliver if course.students.count > 0
  end

  after_update do
    course.students.select('users.id').each do |student|
      Notification.create :user => student, :notificator => self, :kind => 'student_assignment_updated'
    end
  end
end
