class Course < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization

  has_many :assignations
  has_many :teachers, :through => :assignations, :class_name => 'User', :conditions => "users.role = 'teacher'", :source => :user

  has_many :enrollments
  has_many :students, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'accepted'", :source => :user

  has_many :course_assets

  validates_presence_of :network, :name, :description, :start_date, :finish_date

  belongs_to :network
  accepts_nested_attributes_for :course_assets, :allow_destroy => true, :reject_if => lambda { |hash| hash[:file].blank? }

  mount_uploader :logo_file, CourseLogoUploader
  html_sanitized :description

  # hack to save carrierwave assets from cache
  after_save do
    course_assets.each do |image|
      image.update_attribute :file_cache, image.file_cache
    end
  end
end
