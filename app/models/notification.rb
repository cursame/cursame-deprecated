class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to  :user
  belongs_to  :notificator, :polymorphic => true
  before_save :generate_text!

  def generate_text!
    self.text =
      case kind
      when 'student_course_enrollment'
        render course: notificator.course, student: notificator.user
      when 'student_assignment_delivery'
        render delivery: notificator, student: notificator.user, assignment: notificator.assignment
      when 'teacher_survey_replied', 'teacher_survey_updated'
        render survey_reply: notificator, survey: notificator.survey, course: notificator.course, student: notificator.user
      when 'student_course_rejected', 'student_course_accepted'
        render course: notificator.course
      when 'student_assignment_added', 'student_assignment_updated'
        render assignment: notificator, course: notificator.course
      when 'student_survey_added'
        render survey: notificator, course: notificator.course
      when 'user_comment_on_comment'
        render comment: notificator.commentable, user: notificator.user
      when 'user_comment_on_discussion'
        render discussion: notificator.commentable, user: notificator.user
      when 'user_comment_on_user'
        render comment: notificator, user: notificator.user
      when 'user_comment_on_course'
        render comment: notificator , user: notificator.user, course: notificator.commentable
      when 'course_discussion_added'
        render discussion: notificator, course: notificator.course
      when 'finished_uploading_users'
        render asset: notificator.file
      end
  end

  private
  def render locals
    Tilt.new("#{Rails.root}/app/views/notifications/#{kind}.erb").render(self, locals)
  end
end
