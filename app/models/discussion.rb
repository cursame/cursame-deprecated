class Discussion < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  has_many   :comments,  :as => :commentable
  belongs_to :starter, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :course

  validates_presence_of :title, :course, :starter

  can_haz_assets

  html_sanitized :description

  after_create do
    UserMailer.new_discussion(self, self.course.network.subdomain).deliver
  end
  
  def participants_emails(current_user)
    emails = [starter.email]
    self.comments.each{|c| emails << c.user.email unless c.user == current_user }
    emails.uniq.join(", ")
  end
end
