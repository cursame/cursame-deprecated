FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email } 
    password 'password'
    password_confirmation 'password'
    role 'student'
  end

  factory :confirmed_user, :parent => :user do
    confirmed_at { Time.now }
  end

  factory :teacher, :parent => :confirmed_user do
    role 'teacher'
  end
end
