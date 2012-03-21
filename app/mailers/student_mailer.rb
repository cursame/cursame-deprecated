class StudentMailer < ActionMailer::Base
  layout 'mailer'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.accepted_on_course.subject
  #
  def accepted_on_course(student, course, network)
    headers["X-SMTPAPI"] = '{"category": "student accepted on course"}'
    @student = student
    @subdomain = network.subdomain
    @course = course

    if student.accepting_emails
      mail to: student.email,
        subject: t('student_mailer.accepted_on_course.subject', :course_name => course.name)
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.new_homework.subject
  #
  def new_homework(students, course, network)
    headers["X-SMTPAPI"] = '{"category": "student has new homework"}'
    @subdomain = network.subdomain
    @course = course

    mail to: @course.all_emails(nil) 
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.new_survey.subject
  #
  def new_survey(students, course, survey, network)
    headers["X-SMTPAPI"] = '{"category": "student has new survey"}'
    @subdomain = network.subdomain
    @course = course
    @survey = survey

    mail to: @course.all_emails(nil)
  end
end
