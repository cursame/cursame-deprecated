class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :about_me, :studies, :birth_date,
                  :occupation, :twitter_link, :facebook_link, :linkedin_link,
                  :avatar_file, :avatar_file_cache

  has_and_belongs_to_many :networks
  has_many :enrollments
  has_many :courses,                :through => :enrollments
  has_many :manageable_courses,     :through => :enrollments,        :class_name => 'Course', :source => :course, :conditions => {'enrollments.admin' => true}
  has_many :manageable_assignments, :through => :manageable_courses, :source => :assignments, :class_name => 'Assignment'
  has_many :assignments,            :through => :courses
  has_many :enrollment_requests,    :through => :courses, :class_name => 'Enrollment', :source => :enrollments
  has_many :comments

  validates_presence_of :first_name, :last_name

  mount_uploader :avatar_file, AvatarUploader

  def name
    "#{first_name} #{last_name}".strip
  end

  def teacher?
    role == 'teacher'
  end

  def student?
    role == 'student'
  end

  def can_manage_comment? comment
    comments.include?(comment) || 
      case comment.commentable
      when Assignment
        manageable_assignments.include? comment.commentable
      end
  end

  def can_destroy_comment? comment
    puts comment.comments.inspect
    comment.comments.empty? && can_manage_comment?(comment)
  end

  def can_view_comment? comment
    case comment.commentable
    when Assignment
      assignments.include? comment.commentable
    end
  end
end
