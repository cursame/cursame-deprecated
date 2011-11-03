class Course < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization

  has_many :enrollments
  has_many :students, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'accepted' AND enrollments.role = 'student'", :source => :user
  has_many :teachers, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.role  = 'teacher'", :source => :user
  has_many :assets, :as => :owner
  has_many :assignments

  validates_presence_of :network, :name, :description, :start_date, :finish_date

  belongs_to :network

  mount_uploader :logo_file, CourseLogoUploader
  html_sanitized :description

  accepts_nested_attributes_for :assets, :allow_destroy => true, :reject_if => lambda { |hash| hash[:file].blank? }
  # hack to save carrierwave assets from cache
  after_save do
    assets.each do |image|
      image.update_attribute :file_cache, image.file_cache
    end
  end
end
