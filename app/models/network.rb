class Network < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :supervisors, :conditions => {:role => 'supervisor'}, :class_name => 'User'
  has_and_belongs_to_many :teachers,    :conditions => {:role => 'teacher'},    :class_name => 'User'
  has_and_belongs_to_many :students,    :conditions => {:role => 'student'},    :class_name => 'User'
  has_many :courses
  has_many :discussions, :through => :courses
  has_many :assignments, :through => :courses

  accepts_nested_attributes_for :supervisors

  validates_presence_of   :name, :subdomain
  validates_uniqueness_of :subdomain
  validates_format_of     :subdomain, :with => /^[\-a-z0-9]+$/i

  mount_uploader :logo_file, LogoUploader
end
