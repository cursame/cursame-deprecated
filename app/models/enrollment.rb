class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates_inclusion_of :state, :in => %w(pending rejected accepted), :allow_nil => true
  validates_inclusion_of :role,  :in => %w(student teacher)

  after_create do
    if role == 'student'
      course.teachers.select('users.id').each do |teacher|
        Notification.create :user => teacher, :notificator => self, :kind => :student_course_enrollment
      end
    end
  end

  def pending?
    state == 'pending'
  end

  def rejected?
    state == 'rejected'
  end

  def accepted?
    state == 'accepted'
  end
end
