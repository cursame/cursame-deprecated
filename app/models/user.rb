class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :networks

  has_many :assignations
  has_many :lectures, :through => :assignations, :class_name => 'Course', :source => :course


  def teacher?
    role == 'teacher'
  end
end
