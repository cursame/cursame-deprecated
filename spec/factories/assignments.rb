FactoryGirl.define do
  factory :assignment do
    name { Faker::Lorem.words(5).join(' ') }
    description { Faker::Lorem.paragraph }
    value { rand(8) }
    period { rand(100) }
  end
end
