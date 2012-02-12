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
      unless commentable.user.id == self.user.id  # Si el comentario es del mismo usuario que el del comentario no se debe enviar.
        debugger
        UserMailer.send("new_comment_on_#{commentable_type.downcase}", commentable, user, subdomain).deliver
      end
    end

    case commentable_type
    when "Comment"
      unless commentable.user.id == self.user.id  # Si el comentario es del mismo usuario que el del comentario no se debe crear.
        Notification.create(:user => commentable.user, :notificator => self, :kind => 'user_comment_on_comment')
      end
    when "Discussion"
      commentable.course.users.reject { |us| us.id == self.user.id }.each do |u|
        Notification.create :user => u, :notificator => self, :kind => 'user_comment_on_discussion'
      end
    end
  end
  
end
