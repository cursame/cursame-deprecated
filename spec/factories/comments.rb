FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.paragraph }
    commentable { Factory :assignment}
    user { Factory :student }
  end
  
  factory :comment_on_user, :parent => :comment do
    commentable { Factory :student}
  end
end
