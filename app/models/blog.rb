class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comment_posts
  extend ActiveRecord::HTMLSanitization
  
  validates_presence_of :post
  validates_presence_of :content
  validates_presence_of :date
  
  html_sanitized :content
  
end
