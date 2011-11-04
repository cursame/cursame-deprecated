FactoryGirl.define do
  factory :enrollment do
  end

  factory :teacher_enrollment, :parent => :enrollment do
    role 'teacher'
  end

  factory :student_enrollment, :parent => :enrollment do
    role 'student'
    state 'pending'
  end

  factory :admin_enrollment, :parent => :teacher_enrollment do
    admin true
    user { Factory(:teacher) }
  end
end
