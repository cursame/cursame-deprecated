class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :about_me, :studies, :birth_date,
                  :occupation, :twitter_link, :facebook_link, :linkedin_link,
                  :avatar_file, :avatar_file_cache, :role, :state

  has_and_belongs_to_many :networks
  has_many :enrollments
  has_many :courses,                :through => :enrollments
  has_many :visible_courses,        :through => :enrollments,        :class_name => 'Course', :source => :course, :conditions => "enrollments.state = 'accepted' OR enrollments.role = 'teacher'"
  has_many :manageable_courses,     :through => :enrollments,        :class_name => 'Course', :source => :course, :conditions => {'enrollments.admin' => true}
  has_many :manageable_assignments, :through => :manageable_courses, :source => :assignments, :class_name => 'Assignment'
  has_many :manageable_discussions, :through => :manageable_courses, :source => :discussions, :class_name => 'Discussion'
  has_many :enrollment_requests,    :through => :courses, :class_name => 'Enrollment', :source => :enrollments
  has_many :assignments,            :through => :courses
  has_many :discussions,            :through => :courses
  has_many :manageable_discussions, :class_name => 'Discussion'
  has_many :comments

  validates_presence_of :first_name, :last_name
  validates_inclusion_of :role,  :in => %w(student teacher supervisor)
  validates_inclusion_of :state, :in => %w(active inactive)

  mount_uploader :avatar_file, AvatarUploader

  def name
    "#{first_name} #{last_name}".strip
  end

  def active?
    state == 'active'
  end

  def teacher?
    role == 'teacher'
  end

  def student?
    role == 'student'
  end

  def supervisor?
    role == 'supervisor'
  end

  def can_edit_comment? comment
    commentable = comment.commentable
    comments.include?(comment) || 
      case commentable
      when Assignment
        manageable_assignments.include? commentable
      when Course
        manageable_courses.include? commentable
      when Discussion # TODO: no integration test
        manageable_discussions.include? commentable
      when Comment
        can_edit_comment? commentable
      end
  end

  def can_destroy_comment? comment
    comment.comments.empty? && can_edit_comment?(comment)
  end

  def can_view_comment? comment
    commentable = comment.commentable
    case commentable
    when Assignment
      assignments.include? commentable
    when Course
      courses.include? commentable
    when Discussion # TODO: no integration test
      discussions.include? commentable
    end
  end
end
