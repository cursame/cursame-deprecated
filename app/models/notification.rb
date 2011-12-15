class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notificator, :polymorphic => true

  def message
    case kind
    when 'student_course_enrollment
      '
    end
  end
end
