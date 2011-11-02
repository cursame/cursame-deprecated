class Comment < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates_presence_of :text, :commentable, :user

  html_sanitized :text
end
