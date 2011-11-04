# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discussion do
    title { Faker::Lorem.words(3).join(' ') }
    description { Faker::Lorem.paragraph }
    course { Factory(:course) }
    starter { Factory(:teacher) }
  end
end
