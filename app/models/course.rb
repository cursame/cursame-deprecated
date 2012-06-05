# TODO: Quick hack to avoid messing with the views, fixes some broken tests
class Eater
  def method_missing(*args); nil end
end

class Course < ActiveRecord::Base
  extend ActiveRecord::HTMLSanitization
  extend ActiveRecord::AssetsOwner

  has_many :enrollments, :dependent => :destroy
  has_many :pending_students, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'pending' AND enrollments.role = 'student'", :source => :user
  has_many :students,         :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'accepted' AND enrollments.role = 'student'",  :source => :user
  has_many :teachers,         :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'accepted' AND enrollments.role = 'teacher'", :source => :user
  has_many :pending_teachers, :through => :enrollments, :class_name => 'User', :conditions => "enrollments.state = 'pending' AND enrollments.role = 'teacher'", :source => :user
  has_many :users,            :through => :enrollments, :conditions => "(enrollments.state = 'accepted' AND enrollments.role = 'student') OR enrollments.role  = 'teacher'", :source => :user
  has_many :assignments, :dependent => :destroy 
  has_many :surveys, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :chats
  
  can_haz_assets

  validates_presence_of :name, :description, :start_date, :finish_date, :network

  belongs_to :network
  mount_uploader :course_logo_file, CourseLogoUploader
  html_sanitized :description
 
  def owner
    teachers.where("enrollments.admin" => true).order("created_at asc").first or Eater.new
  end

  def self.total_open_courses
    self.where(:public => true).count
  end

  def self.total_private_courses
    self.where(:public => false).count
  end
  
  def can_be_destroyed_by?(user)
    return true if user == owner or user.supervisor?
  end
  
  def student_emails
    mails = []
    self.students.map{ |u| mails << u.email if u.accepting_emails }.compact.join(", ")
  end

  #Metodo que regresa en un string separado por comas los emails de los usuarios del curso
  def all_emails(current_user)
    mails = []
    self.users.map{ |u| mails << u.email unless u == current_user || !u.accepting_emails }.compact.join(", ")
  end
end

