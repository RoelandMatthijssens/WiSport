# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_login_service do
    user nil
    provider "MyString"
    uid "MyString"
    login "MyString"
    acces_token "MyString"
  end
end
