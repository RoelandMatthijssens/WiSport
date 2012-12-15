# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :do_session do
    user nil
    visibility "MyString"
    remarks "MyText"
    trainings_session nil
  end
end
