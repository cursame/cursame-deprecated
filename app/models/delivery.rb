class Delivery < ActiveRecord::Base
  default_scope includes(:assignment)

  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  belongs_to :assignment
  belongs_to :user
  validates_presence_of :assignment
  has_many :comments, :as => :commentable

  can_haz_assets

  html_sanitized :content
end
