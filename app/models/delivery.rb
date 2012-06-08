class Delivery < ActiveRecord::Base
  default_scope includes(:assignment)  
  has_one :calificationem
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner
  belongs_to :assignment
  belongs_to :user
  has_many :comments, :as => :commentable

  validates_presence_of :assignment
  validates_uniqueness_of :assignment_id, :scope => [:user_id]

  can_haz_assets

  html_sanitized :content

  validate do
    errors.add(:base, 'Due date has passed') if assignment.due_to < DateTime.now
  end

  after_create do
    assignment.course.teachers.select('users.id').each do |teacher|
      Notification.create :user => teacher, :notificator => self, :kind => 'student_assignment_delivery'
    end
  end
  def score   
       (100 * raiting/assignment.value).to_i    
   end
   
  def limit
  assignment.value
  end
  
  
end
