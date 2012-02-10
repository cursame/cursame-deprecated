class Comment < ActiveRecord::Base
  default_scope :include => [:commentable]

  extend ActiveRecord::HTMLSanitization

  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  has_many :comments, :as => :commentable

  validates_presence_of :text, :commentable, :user

  html_sanitized :text
  
  after_create do
    if ["User", "Discussion", "Course", "Comment"].include?(commentable_type)
      subdomain = user.networks.first.subdomain if user.networks.first
      UserMailer.send("new_comment_on_#{commentable_type.downcase}", commentable, user, subdomain).deliver
    end

    case commentable_type
    when "Comment"
      Notification.create :user => commentable.user, :notificator => self, :kind => 'user_comment_on_comment'
    when "Discussion"
      commentable.course.users.each do |u|
        Notification.create :user => u, :notificator => self, :kind => 'user_comment_on_discussion'
      end
    end
  end
  
end
