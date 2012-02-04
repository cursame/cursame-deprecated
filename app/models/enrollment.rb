class Enrollment < ActiveRecord::Base
  include ActiveRecord::Transitions
  
  belongs_to :user
  belongs_to :course
  validates_inclusion_of :role,  :in => %w(student teacher)

  state_machine do
    state :pending,  :enter => :enrollment_requested
    state :accepted, :enter => :enrollment_accepted
    state :rejected, :enter => :enrollment_rejected

    event :request do
      transitions :to => :pending, :from => [:pending, :rejected]
    end

    event :accept do
      transitions :to => :accepted, :from => :pending
    end

    event :reject do
      transitions :to => :rejected, :from => [:pending, :accepted]
    end
  end

  def enrollment_requested
    course.teachers.select('users.id').each do |teacher|
      Notification.create :user => teacher, :notificator => self, :kind => 'student_course_enrollment'
    end
    TeacherMailer.pending_student_on_course(course.teachers, user, course, course.network).deliver
  end

  def enrollment_rejected
    Notification.create :user => user, :notificator => self, :kind => 'student_course_rejected'
  end

  def enrollment_accepted
    Notification.create :user => user, :notificator => self, :kind => 'student_course_accepted'
    StudentMailer.accepted_on_course(self.user, self.course, course.network).deliver
  end

  def student?
    role == 'student'
  end

  def pending?
    student? && state == 'pending'
  end

  def rejected?
    student? && state == 'rejected'
  end

  def accepted?
    student? && state == 'accepted'
  end
end
