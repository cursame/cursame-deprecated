# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
      name { Faker::Lorem.words(5).join(' ') }
      description { Faker::Lorem.paragraph(2) }
      start_date { Time.now }
      finish_date { 1.month.from_now }
      public false
      reference "MyString"
    end
end
