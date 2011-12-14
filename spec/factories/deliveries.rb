# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delivery do
    content { Faker::Lorem.paragraph }
    assignment { Factory(:assignment) }
  end
end
