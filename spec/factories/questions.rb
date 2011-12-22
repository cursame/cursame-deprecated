FactoryGirl.define do
  factory :question do
    text { Faker::Lorem.words(5).join(' ') }
    answers_attributes { 1.upto(4).map { |i| Factory.attributes_for(:answer, :index => i) } }
    answer_index { |q| q.answers.last.index }
  end
end
