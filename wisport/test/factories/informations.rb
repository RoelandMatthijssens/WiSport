FactoryGirl.define do
	factory :information do
		media Faker::Lorem.sentence
		description Faker::Lorem.paragraph
	end
end
