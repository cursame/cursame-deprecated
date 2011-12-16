FactoryGirl.define do
  factory :survey do
    name { Faker::Lorem.words(5).join(' ') }
    description { Faker::Lorem.paragraph }
    value { rand(100) }
    period { rand(7) + 1 }
    due_to { 1.month.from_now }
    course { Factory :course }
  end


  factory :survey_with_questions, :parent => :survey do
    after_create do |survey|
      (1..3).map { Factory(:question_with_answers, :survey => survey) }
    end
  end
end
