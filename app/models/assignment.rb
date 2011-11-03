class Assignment < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization

  belongs_to :course
  has_many :comments, :as => :commentable

  validates_presence_of :name, :description, :value, :period, :due_to, :course
  validates_inclusion_of :value,  :in =>(0..100)
  validates_inclusion_of :period, :in =>(1..8)

  html_sanitized :description
end
