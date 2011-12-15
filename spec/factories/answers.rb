# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    text { Lorem.words(5).join(' ') }
    question { Factory(:question) }
  end
end
