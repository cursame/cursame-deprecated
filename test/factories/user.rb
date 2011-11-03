FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email } 
    password 'password'
    password_confirmation 'password'
    role 'student'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :confirmed_user, :parent => :user do
    confirmed_at { Time.now }
  end

  factory :teacher, :parent => :confirmed_user do
    role 'teacher'
  end

  factory :student, :parent => :confirmed_user do
  end
end
