class Network < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :supervisors, :conditions => {:role => 'supervisor'}, :class_name => 'User'
  has_and_belongs_to_many :teachers,    :conditions => {:role => 'teacher'}, :class_name => 'User'
  has_and_belongs_to_many :students,    :conditions => {:role => 'student'}, :class_name => 'User'

  accepts_nested_attributes_for :supervisors

  has_many :courses

  validates_presence_of   :name, :subdomain
  validates_uniqueness_of :subdomain
  validates_format_of     :subdomain, :with => /^[\-a-z0-9]+$/i
end
