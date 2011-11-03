class Course < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  has_many :enrollments
  has_many :students, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'accepted' AND enrollments.role = 'student'", :source => :user
  has_many :teachers, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.role  = 'teacher'", :source => :user
  has_many :assignments
  has_many :assets, :as => :owner

  can_haz_assets

  validates_presence_of :network, :name, :description, :start_date, :finish_date

  belongs_to :network

  mount_uploader :logo_file, CourseLogoUploader
  html_sanitized :description
end
