class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :about_me, :studies, :birth_date,
                  :occupation, :twitter_link, :facebook_link, :linkedin_link, :bussines_role,

                  :avatar_file, :avatar_file_cache, :role, :state, :terms_of_service,
                  :accepting_emails, :id, :authentication_token
  
  has_many :rankings
  has_many :top_users, :through => :rankings
  has_and_belongs_to_many :networks
  has_many :enrollments
  has_many :courses,                   :through => :enrollments # may go away
  has_many :visible_courses,           :through => :enrollments,            :class_name => 'Course',      :source => :course,      :conditions => "enrollments.state = 'accepted'"
  has_many :manageable_courses,        :through => :enrollments,            :class_name => 'Course',      :source => :course,      :conditions => {'enrollments.admin' => true, 'enrollments.role' => 'teacher'}
  has_many :manageable_assignments,    :through => :manageable_courses,     :class_name => 'Assignment',  :source => :assignments
  has_many :manageable_surveys,        :through => :manageable_courses,     :class_name => 'Survey',      :source => :surveys
  has_many :manageable_discussions,    :through => :manageable_courses,     :class_name => 'Discussion',  :source => :discussions
  has_many :manageable_deliveries,     :through => :manageable_assignments, :class_name => 'Delivery',    :source => :deliveries
  has_many :manageable_survey_replies, :through => :manageable_surveys,     :class_name => 'SurveyReply', :source => :survey_replies
  has_many :assignments,               :through => :courses
  has_many :surveys,                   :through => :courses
  has_many :discussions,               :through => :courses
  has_many :manageable_discussions,    :class_name => 'Discussion'
  has_many :enrollment_requests,       :through => :courses, :class_name => 'Enrollment', :source => :enrollments
  has_many :comments
  has_many :actions
  has_many :chats
  has_many :calendar_activities
  has_many :blogs
  has_many :comment_posts
  has_many :send_reports
  has_many :bug_answers
  # TODO: refactor commentable models to homogenize access to comments (below)
  has_many :profile_comments, :as => :commentable, :class_name => 'Comment', :source => :comment
  has_many :deliveries
  has_many :notifications
  has_many :survey_replies
  has_many :statuses 
  has_many :favorites
  # SE comoloca el cambio de tipo de usuario-
  has_many :new_users_change_types
  # se coloca el confirmar aceptación de usuario-
  has_many :accepted_terms
 
  validates_presence_of :first_name, :last_name
  validates_inclusion_of :role,  :in => %w(student teacher supervisor admin)
  validates_inclusion_of :state, :in => %w(active inactive)

  validate :correct_email_if_private_registration

  validates_acceptance_of :terms_of_service

  mount_uploader :avatar_file, AvatarUploader

  scope :ordered, order('created_at DESC')
  
  def network
    self.networks.first
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def active?
    state == 'active'
  end
  
  def fantom?
    view_status == 'fantom'
  end
  
  def live?
    view_status == 'live'
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

  def admin?
    role == 'admin'
  end

  def self.search(search="")
    search ? where("((users.first_name || ' ' || users.last_name) #{LIKE} ?) OR
                   (users.first_name #{LIKE}  ?) OR (users.last_name #{LIKE} ?)",
                   "%#{search}%", "%#{search}%", "%#{search}%") : self.ordered
  end

  def self.total_supervisors
    self.where(:role => "supervisor").count
  end

  def self.total_teachers
    self.where(:role => "teacher").count
  end

  def self.total_students
    self.where(:role => "student").count
  end

  def role_for_course course
    if self.supervisor?
      "supervisor"
    else
      enrollments.where(:course_id => course).first.role
    end
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
          when User
            profile_comments.include? comment
          when Delivery
            deliveries.include?(commentable) || manageable_deliveries.include?(commentable)
          when Comment # TODO: no integration test to test deleting comment of comment
            can_edit_comment? commentable
        end
  end

  def can_destroy_comment? comment
    comment.comments.empty? && can_edit_comment?(comment)
  end

  def can_view_comment? comment
    commentable = comment.commentable
    return true if self.supervisor? #In case is a supervisor can always post comments
    case commentable
      when Assignment
        assignments.include? commentable
      when Course
        courses.include? commentable
      when Discussion # TODO: no integration test
        discussions.include? commentable
      when Delivery
        deliveries.include?(commentable) || manageable_deliveries.include?(commentable)
      when User
        true
      when Comment
        self.supervisor?
    end
  end

  def can_manage_course? course
    (self.supervisor? and !course.network.users.find(self.id).nil?) || self.manageable_courses.where('courses.id' => course).count > 0
  end

  def devise_mailer_subdomain
    if self.networks.blank? and self.supervisor?
      Network.last.subdomain
    elsif !self.networks.blank?
      self.networks.first.subdomain
    end
  end

  def received_likes
    likes = 0
    self.comments.each do |comment|
      likes += comment.like_not_likes.count
    end
    return likes
  end

  private
  def correct_email_if_private_registration
    network = self.networks.first
    if network
      permitted_email = network.registry_domain.downcase if network.private_registry
      if self.new_record? and network.private_registry and !self.email.downcase[permitted_email]
        errors.add(:email, I18n.t('.user.errors.email_not_allowed'))
      end
    end
  end
  
end
