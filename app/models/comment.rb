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
      unless commentable_id == self.user.id  # Si el comentario es del mismo usuario que el del creador no se debe enviar correo.
        mail = UserMailer.send("new_comment_on_#{commentable_type.downcase}", commentable, user, subdomain)
        mail.deliver if (mail.to or mail.bcc or mail.cc)
      end
    end

    case commentable_type
    when "Comment"
      unless commentable.user.id == self.user.id 
        Notification.create :user => commentable.user, :notificator => self, :kind => 'user_comment_on_comment'
      end
    when "Discussion"
      commentable.course.users.reject { |us| us.id == self.user.id }.each do |u|
        Notification.create :user => u, :notificator => self, :kind => 'user_comment_on_discussion'
      end
    when "User"
      unless commentable_id == self.user.id
        Notification.create :user => commentable, :notificator => self, :kind => 'user_comment_on_user'
      end
    when "Course"
      commentable.users.reject { |us| us.id == self.user.id }.each do |u|
        Notification.create :user => u, :notificator => self, :kind => 'user_comment_on_course'
      end
    end
  end

  def self.total_comments_assignments
    self.where(:commentable_type => "Assignment").count
  end
  
  def self.total_comments_discussions
    self.where(:commentable_type => "Discussion").count
  end

  def self.total_comments_user_walls
    self.where(:commentable_type => "User").count
  end

  def self.total_comments_course_walls
    self.where(:commentable_type => "Course").count
  end
  

  private

  def commentable_id
    case commentable_type
    when "User"
      return commentable.id
    when "Comment" 
      return commentable.user.id
    when "Discussion"
      return commentable.starter.id
    end
    nil
  end
  
end
