class Course < ActiveRecord::Base
  has_many :assignations
  has_many :teachers, :through => :assignations, :class_name => 'User', :conditions => "users.role = 'teacher'", :source => :user

  has_many :enrollments
  has_many :students, :through => :enrollments, :class_name => 'User', :source => :user

  has_many :course_assets

  validates_presence_of :network

  belongs_to :network
  accepts_nested_attributes_for :course_assets, :allow_destroy => true

  mount_uploader :logo_file, CourseLogoUploader

  # hack to save carrierwave assets from cache
  after_save do
    course_assets.each do |image|
      image.update_attribute :file_cache, image.file_cache
    end
  end
end
