FactoryGirl.define do
  factory :answer do
    uuid {  UUID.new.generate }
    text { Faker::Lorem.words(5).join(' ') }
    sequence(:position) { |i| i }
  end
end
