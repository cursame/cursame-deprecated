FactoryGirl.define do
  factory :question do
    text { Faker::Lorem.words(5).join(' ') }
    answers_attributes { 1.upto(4).map { |i| Factory.attributes_for(:answer, :position => i) } }
    answer_position { |q| q.answers.last.position }
    value { 1 }
  end
end
