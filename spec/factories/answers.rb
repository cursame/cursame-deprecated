FactoryGirl.define do
  factory :answer do
    text { Faker::Lorem.words(5).join(' ') }
    sequence(:position) { |i| i }
  end
end
