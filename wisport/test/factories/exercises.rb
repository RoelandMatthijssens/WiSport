FactoryGirl.define do
	factory :exercise do
		sequence(:name ) {|n| Faker::Lorem.word}
		sequence(:title) {|n| Faker::Lorem.sentence}
		sequence(:typee) {|n| Faker::Lorem.word}
		information
	end
end
