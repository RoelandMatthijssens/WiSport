# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :do_exercise do
    user nil
    visibility "MyString"
    distance 1.5
    reps 1
    hours 1
    minutes 1
    seconds 1
    exercise nil
    do_session nil
  end
end
