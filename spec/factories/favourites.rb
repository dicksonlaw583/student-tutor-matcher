# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favourite do
    favourite_tutor_id 1
    liking_student_id 1
  end
end
