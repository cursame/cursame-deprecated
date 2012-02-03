class Comment < ActiveRecord::Base
  default_scope :include => [:commentable]

  extend ActiveRecord::HTMLSanitization

  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  has_many :comments, :as => :commentable

  validates_presence_of :text, :commentable, :user

  html_sanitized :text
  
  after_create do
    UserMailer.send("new_comment_on_#{commentable_type.downcase}".to_sym, commentable, user, user.networks.first.subdomain).deliver
  end
  
end
