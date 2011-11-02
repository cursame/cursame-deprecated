FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.paragraph }
    commentable { Factory :assignment}
    user { Factory :student }
  end
end
