# TODO: Quick hack to avoid messing with the views, fixes some broken tests
class Eater
  def method_missing(*args); nil end
end

class Course < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  has_many :enrollments
  has_many :pending_students, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'pending' AND enrollments.role = 'student'", :source => :user
  has_many :students,         :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'accepted' AND enrollments.role = 'student'",  :source => :user
  has_many :teachers,         :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'accepted' AND enrollments.role = 'teacher'", :source => :user
  has_many :pending_teachers, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'pending' AND enrollments.role = 'teacher'", :source => :user
  has_many :users,            :through => :enrollments, :conditions => "(enrollments.state = 'accepted' AND enrollments.role = 'student') OR enrollments.role  = 'teacher'", :source => :user
  has_many :assignments
  has_many :surveys
  has_many :discussions
  has_many :comments, :as => :commentable

  can_haz_assets

  validates_presence_of :name, :description, :start_date, :finish_date, :network

  belongs_to :network

  mount_uploader :logo_file, CourseLogoUploader
  html_sanitized :description
  
  def owner
    teachers.where("enrollments.admin" => true).first or Eater.new
  end

  #Metodo que regresa en un string separado por comas los emails de los usuarios del curso
  def all_emails(current_user)
    mails = []
    self.users.map{ |u| mails << u.email unless u == current_user }.join(", ")
  end
end

