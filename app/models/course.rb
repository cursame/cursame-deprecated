class Course < ActiveRecord::Base
  has_many :assignations
  has_many :teachers, :through => :assignations, :class_name => 'User', :conditions => "users.role = 'teacher'", :source => :user
  has_many :course_assets
  validates_presence_of :network

  belongs_to :network
  
  #has_many :students, :through => :blah, :class_name => 'User'
end
