FactoryGirl.define do
  factory :notification do
  end

  factory :student_course_enrollment, :parent => :notification do
    kind 'student_course_enrollment'
    notificator { Factory(:student_enrollment) }
  end

  factory :student_assignment_delivery, :parent => :notification do
    kind 'student_assignment_delivery'
    notificator { Factory(:delivery) }
  end

  factory :student_course_rejected, :parent => :notification do
    kind 'student_course_rejected'
    notificator { Factory(:student_enrollment) }
  end

  factory :student_course_accepted, :parent => :notification do
    kind 'student_course_accepted'
    notificator { Factory(:student_enrollment) }
  end

  factory :student_assignment_added, :parent => :notification do
    kind 'student_assignment_added'
    notificator { Factory(:assignment) }
  end

  factory :student_assignment_updated, :parent => :notification do
    kind 'student_assignment_updated'
    notificator { Factory(:assignment) }
  end

  factory :student_survey_added, :parent => :notification do
    kind 'student_survey_added'
    notificator { Factory(:survey) }
  end

  factory :teacher_survey_replied, :parent => :notification do
    kind 'teacher_survey_replied'
    notificator { Factory(:survey_reply) }
  end

  factory :teacher_survey_updated, :parent => :notification do
    kind 'teacher_survey_updated'
    notificator { Factory(:survey_reply) }
  end

  factory :user_comment_on_comment, :parent => :notification do
    kind 'user_comment_on_comment'
    notificator { Factory(:comment) }
  end

  factory :user_comment_on_discussion, :parent => :notification do
    kind 'user_comment_on_comment'
    notificator { Factory(:discussion) }
  end

  factory :user_comment_on_user, :parent => :notification do
    kind 'user_comment_on_comment'
    notificator { Factory(:user) }
  end

  factory :user_comment_on_course, :parent => :notification do
    kind 'user_comment_on_comment'
    notificator { Factory(:user) }
  end

  factory :course_discussion_added, :parent => :notification do
    kind 'course_discussion_added'
    notificator { Factory(:discussion) }
  end
end
