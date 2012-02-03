class Discussion < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  has_many   :comments,  :as => :commentable
  belongs_to :starter, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :course

  validates_presence_of :title, :course, :starter

  can_haz_assets

  html_sanitized :description
  
  def participants_emails
    emails = [starter.email]
    self.comments.each{|c| emails << c.user.email }
    emails.uniq.join(", ")
  end
end
