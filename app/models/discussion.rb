class Discussion < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  has_many   :comments,  :as => :commentable, :dependent => :destroy
  belongs_to :starter, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :course

  validates_presence_of :title, :course, :starter

  can_haz_assets

  html_sanitized :description

  after_create do
    UserMailer.new_discussion(self, self.course.network.subdomain).deliver if self.course.users.count > 1

    # Se crea una notificación para todos los usuarios del curso excepto al creador de la discusión
    self.course.users.reject { |us| us.id == self.starter.id }.each do |u|
      Notification.create :user => u, :notificator => self, :kind => "course_discussion_added"
    end
  end
  
  def participants_emails(current_user)
    emails = [starter.email]
    self.comments.each{|c| emails << c.user.email unless c.user == current_user || !c.user.accepting_emails }
    emails.uniq.join(", ")
  end
end
