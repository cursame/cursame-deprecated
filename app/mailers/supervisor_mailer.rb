class SupervisorMailer < ActionMailer::Base
  layout 'mailer'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.supervisor_mailer.new_teacher_registered.subject
  #
  def new_teacher_registered(teacher, network)
    headers["X-SMTPAPI"] = '{"category": "new teacher registered"}'
    @teacher = teacher
    @network = network

    mail to: network.supervisors.all.map(&:email).join(", "),
         subject: "Un maestro ha solicitado acceso a tu red"
  end
end
