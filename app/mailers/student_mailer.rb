class StudentMailer < ActionMailer::Base
  default from: "noreply@cursa.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.accepted_on_course.subject
  #
  def accepted_on_course(student, course, network)
    @student = student
    @subdomain = network.subdomain
    @course = course

    mail to: student.email,
         subject: t('student_mailer.accepted_on_course.subject', :course_name => course.name)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.new_homework.subject
  #
  def new_homework(students, course, network)
    @subdomain = network.subdomain
    @course = course

    mail to: students.all.map(&:email).join(", ")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.new_survey.subject
  #
  def new_survey(students, course, survey, network)
    @subdomain = network.subdomain
    @course = course
    @survey = survey

    mail to: students.all.map(&:email).join(", ")
  end
end
