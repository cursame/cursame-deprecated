FactoryGirl.define do
  factory :question do
    text { Faker::Lorem.words(5).join(' ') }
    answers_attributes { 1.upto(4).map { |i| Factory.attributes_for(:answer, :position => i) } }
    correct_answer { |q| q.answers.last }
    value { 1 }
  end
end
