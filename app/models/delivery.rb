class Delivery < ActiveRecord::Base
  default_scope includes(:assignment)

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
end
