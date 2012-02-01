class TeacherMailer < ActionMailer::Base
  default from: "noreply@cursa.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.teacher_mailer.pending_student_on_course.subject
  #
  def pending_student_on_course(teachers, student, course, network)
    @student = student
    @course = course
    @subdomain = network.subdomain

    mail to: teachers.all.map(&:email).join(", "),
         subject: "Un alumno ha solicitado acceso a uno de tus cursos"
  end
end
