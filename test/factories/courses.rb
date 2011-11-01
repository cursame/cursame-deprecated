# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
      name "MyString"
      description "MyString"
      start_date "2011-10-31"
      finish_date "2011-10-31"
      public false
      group "MyString"
    end
end