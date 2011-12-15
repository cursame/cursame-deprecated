# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey do
    name { Faker::Lorem.words(5).join(' ') }
    description { Faker::Lorem.paragraph }
    value { rand(100) }
    period { rand(7) + 1 }
    due_to { 1.month.from_now }
    course { Factory :course }
  end
end
