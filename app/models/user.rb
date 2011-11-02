class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  has_and_belongs_to_many :networks

  has_many :assignations
  has_many :lectures, :through => :assignations, :class_name => 'Course', :source => :course
  has_many :manageable_lectures, :through => :assignations, :class_name => 'Course', :source => :course, :conditions => {'assignations.admin' => true}

  has_many :enrollments
  has_many :courses,     :through => :enrollments
  has_many :assignments, :through => :courses

  def teacher?
    role == 'teacher'
  end

  def student?
    role == 'student'
  end
end
