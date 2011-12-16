# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    text { Faker::Lorem.words(5).join(' ') }
  end


  factory :question_with_answers, :parent => :question do
    after_create do |question|
      (1..4).map { Factory(:answer, :question => question) }
    end
  end
end
