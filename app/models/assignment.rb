class Assignment < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  belongs_to :course
  has_many   :deliveries
  has_many   :comments, :as => :commentable

  validates_presence_of :name, :description, :value, :period, :due_to, :course
  validates_inclusion_of :value,  :in =>(0..100)
  validates_inclusion_of :period, :in =>(1..8)

  can_haz_assets

  html_sanitized :description
end
