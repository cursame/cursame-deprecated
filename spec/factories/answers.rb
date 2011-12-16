# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    text { Faker::Lorem.words(5).join(' ') }
  end
end
