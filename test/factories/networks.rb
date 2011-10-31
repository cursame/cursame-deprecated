# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :network do
    subdomain { Faker::Lorem.words(1).join } 
    name { Faker::Lorem.words(3).join(' ') }
  end
end
