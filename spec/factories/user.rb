FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email } 
    password 'password'
    password_confirmation 'password'
    role 'student'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    state 'active'
    accepting_emails true
  end

  factory :confirmed_user, :parent => :user do
    confirmed_at { Time.now }
  end

  factory :supervisor, :parent => :confirmed_user do
    role 'supervisor'
  end

  factory :teacher, :parent => :confirmed_user do
    role 'teacher'
  end

  factory :student, :parent => :confirmed_user do
  end

  factory :admin, :parent => :confirmed_user do
    # You won't be able to directly instantiate this user, since the role
    # 'superadmin' is not allowed by the model. Create it like:
    # a = Factory.build(:admin)
    # a.save(:validate => false)
    role 'admin'
  end
end
