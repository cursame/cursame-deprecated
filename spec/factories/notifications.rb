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
end
