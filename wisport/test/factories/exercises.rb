FactoryGirl.define do
	factory :exercise do
		name Faker::Lorem.words 1
		title Faker::Lorem.words 3
		typee Faker::Lorem.words 1
		information
	end
end
