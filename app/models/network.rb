class Network < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :courses
  validates_uniqueness_of :subdomain
end
