class StudentMailer < ActionMailer::Base
  default from: "noreply@cursa.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.accepted_on_course.subject
  #
  def accepted_on_course(teacher, student, course, network)
    @teacher = teacher
    @student = student
    @subdomain = network.subdomain
    @course = course

    mail to: student.email,
         subject: "Solicitud de ingreso al curso #{course.name} aceptada"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.new_homework.subject
  #
  def new_homework
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.new_survey.subject
  #
  def new_survey
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
