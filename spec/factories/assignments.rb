FactoryGirl.define do
  factory :assignment do
    name { Faker::Lorem.words(5).join(' ') }
    description { Faker::Lorem.paragraph }
    value { rand(100) }
    period { rand(7) + 1 }
    due_to { 1.month.from_now }
    course { Factory :course }
    start_at { 1.day.from_now }
  end

  factory :published_assignment, :parent => :assignment do
    start_at { DateTime.now }
  end

  factory :published_finished_assignment, :parent => :assignment do
    start_at { DateTime.yesterday }
    due_to { DateTime.now - 1.hour }
  end
end
