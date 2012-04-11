FactoryGirl.define do
  factory :survey do
    name { Faker::Lorem.words(5).join(' ') }
    description { Faker::Lorem.paragraph }
    value { rand(100) }
    period { rand(7) + 1 }
    due_to { 1.month.from_now }
    course { Factory :course }
    questions { [Factory(:question)] }
    start_at { 1.day.from_now }
  end

  factory :published_survey, :parent => :survey do
    start_at { DateTime.now }
  end
end
