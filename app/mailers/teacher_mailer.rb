class TeacherMailer < ActionMailer::Base
  layout 'mailer'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.teacher_mailer.pending_student_on_course.subject
  #
  def pending_user_on_course(teachers, user, course, network)
    headers["X-SMTPAPI"] = '{"category": "pending user on course"}'
    @user = user
    @course = course
    @subdomain = network.subdomain

    mail to: teachers.map(&:email).join(", ")
  end
end
