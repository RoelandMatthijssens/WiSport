FactoryGirl.define do
	factory :user do
		sequence(:username){|n| "#{Faker::Internet.user_name}"}
		sequence(:email){|n| "#{Faker::Internet.email}"}
		password 'abc123'
		password_confirmation 'abc123'
	end
end
