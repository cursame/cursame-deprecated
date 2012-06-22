class CommentPost < ActiveRecord::Base
  belongs_to :blog
  
  extend ActiveRecord::HTMLSanitization
  
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :date
  
  html_sanitized :content
end
