class UserMailer < ActionMailer::Base
  layout 'mailer'
  helper UserMailerHelper
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
  
  def new_comment_on_discussion(discussion, commenter, subdomain)
    @discussion = discussion
    @commenter = commenter
    @subdomain = subdomain

    mail bcc: discussion.participants_emails(commenter)
  end

  def new_comment_on_course(course, commenter, subdomain)
    @course = course
    @commenter = commenter
    @subdomain = subdomain

    mail bcc: course.all_emails(commenter)
  end
  
  def new_comment_on_comment(parent_comment, commenter, subdomain)
    @parent = parent_comment
    @commenter = commenter
    @subdomain = subdomain

    mail to: @parent.user.email
  end

  def new_discussion(discussion, subdomain)
    @discussion = discussion
    @subdomain = subdomain

    mail bcc: discussion.course.all_emails(discussion.starter)
  end
end
