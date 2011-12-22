FactoryGirl.define do
  factory :answer do
    text { Faker::Lorem.words(5).join(' ') }
    sequence(:index) { |i| i }
  end
end
