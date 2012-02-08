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
  end
  
end
