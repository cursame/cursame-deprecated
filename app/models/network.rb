class Network < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :supervisors, :conditions => {:role => 'supervisor'}, :class_name => 'User'
  has_and_belongs_to_many :teachers,    :conditions => {:role => 'teacher'},    :class_name => 'User'
  has_and_belongs_to_many :students,    :conditions => {:role => 'student'},    :class_name => 'User'
  has_many :courses
  has_many :discussions, :through => :courses
  has_many :assignments, :through => :courses
  has_many :surveys,     :through => :courses  
  accepts_nested_attributes_for :supervisors

  validates_presence_of   :name, :subdomain
  validates_uniqueness_of :subdomain
  validates_format_of     :subdomain, :with => /^[\-a-z0-9]+$/i
  
  before_save :downcase_subdomain
  
  validates_presence_of :registry_domain, :if => :registry_is_private, :on => :update

  mount_uploader :logo_file, LogoUploader
  
  private
  
  def downcase_subdomain
    self.subdomain.downcase! unless self.subdomain.blank?
  end
  
  def registry_is_private
    self.private_registry
  end
end
