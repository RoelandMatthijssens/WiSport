FactoryGirl.define do
	factory :information do
		sequence(:media )       {|n| Faker::Lorem.sentence}
		sequence(:description ) {|n| Faker::Lorem.paragraph}
	end
end
