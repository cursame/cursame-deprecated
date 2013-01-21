class UserMailer < ActionMailer::Base
  layout 'mailer'
  helper UserMailerHelper
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_comment_on_wall.subject
  #
  def new_comment_on_user(commented, commenter, subdomain)
    headers["X-SMTPAPI"] = '{"category": "user wall comment"}'
    @commented = commented
    @commenter = commenter
    @subdomain = subdomain

    mail to: commented.email if commented.accepting_emails
  end
  
  def new_comment_on_discussion(discussion, commenter, subdomain)
    headers["X-SMTPAPI"] = '{"category": "discussion wall comment"}'
    @discussion = discussion
    @commenter = commenter
    @subdomain = subdomain

    mail bcc: discussion.participants_emails(commenter) if !discussion.participants_emails(commenter).blank?
  end

  def new_comment_on_course(course, commenter, subdomain)
    headers["X-SMTPAPI"] = '{"category": "course wall comment"}'
    @course = course
    @commenter = commenter
    @subdomain = subdomain

    mail bcc: course.all_emails(commenter) if !course.all_emails(commenter).blank?
  end
  
  def new_comment_on_comment(parent_comment, commenter, subdomain)
    headers["X-SMTPAPI"] = '{"category": "comment on comment"}'
    @parent = parent_comment
    @commenter = commenter
    @subdomain = subdomain

    mail to: @parent.user.email if @parent.user.accepting_emails
  end

  def new_discussion(discussion, subdomain)
    headers["X-SMTPAPI"] = '{"category": "new discussion"}'
    @discussion = discussion
    @subdomain = subdomain

    mail bcc: discussion.course.all_emails(discussion.starter)
  end

  def new_user_by_supervisor(user, network, password)
    headers["X-SMTPAPI"] = '{"category": "new user"}'
    @user = user
    @network = network
    @password = password

    mail(to: @user.email)
  end

  def user_password(user, password)
    headers["X-SMTPAPI"] = '{"category": "user password"}'
    @user = user
    @password = password

    mail(to: @user.email)
  end

end
