class UserMailer < ActionMailer::Base
  default from: "noreply@cursa.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_comment_on_wall.subject
  #
  def new_comment_on_user(commented, commenter, subdomain)
    @commented = commented
    @commenter = commenter
    @subdomain = subdomain

    mail to: commented.email
  end
  
    # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_comment_on_discussion.subject
  #
  def new_comment_on_discussion(discussion, commenter, subdomain)
    @discussion = discussion
    @commenter = commenter
    @subdomain = subdomain

    mail bcc: discussion.participants_emails
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_comment_on_course_wall.subject
  #
  def new_comment_on_course
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_discussion.subject
  #
  def new_discussion
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
