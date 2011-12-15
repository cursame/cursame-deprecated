# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    text { Lorem.words(5).join(' ') }
    course { Factory(:course) }
    answers { 1.upto(5).map { Factory(:answer) } }
    correct_anser { |q| q.answers.first }
  end
end
