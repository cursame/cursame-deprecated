class Comment < ActiveRecord::Base
  default_scope :include => [:commentable]

  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :like_not_likes
  validates_presence_of :text, :commentable, :user
  
  can_haz_assets

  html_sanitized :text
  
  after_create do
    subdomain = user.networks.first.subdomain if user.networks.first

    case commentable_type
    when "Comment"
      unless commentable.user.id == self.user.id 
        Notification.create :user => commentable.user, :notificator => self, :kind => 'user_comment_on_comment'
        UserMailer.delay.new_comment_on_comment(commentable, user, subdomain) if commentable.user.accepting_emails
      end
    when "Discussion"
      commentable.course.users.reject { |us| us.id == self.user.id }.each do |u|
        Notification.create :user => u, :notificator => self, :kind => 'user_comment_on_discussion'
      end
      UserMailer.delay.new_comment_on_discussion(commentable, user, subdomain) unless commentable.participants_emails(user).blank?
    when "User"
      unless commentable_id == self.user.id
        Notification.create :user => commentable, :notificator => self, :kind => 'user_comment_on_user'
        UserMailer.delay.new_comment_on_user(commentable, user, subdomain) if commentable.accepting_emails
      end
    when "Course"
      commentable.users.reject { |us| us.id == self.user.id }.each do |u|
        Notification.create :user => u, :notificator => self, :kind => 'user_comment_on_course'
      end
      UserMailer.delay.new_comment_on_course(commentable, user, subdomain) unless commentable.all_emails(user).blank?
    end
  end



  private

  def commentable_id
    case commentable_type   
    when "User"
      return commentable.id
    when "Comment" 
      return commentable.user.id if commentable.user
    when "Discussion"
      return commentable.starter.id
     when "Network"
       return commentable.id
    end
    nil
  end
  
end
