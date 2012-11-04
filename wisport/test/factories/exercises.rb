FactoryGirl.define do
	factory :exercise do
		sequence(:name ) {|n| Faker::Lorem.word}
		sequence(:title) {|n| Faker::Lorem.sentence}
		type ["DistanceExercise","TimeExercise","RepsExercise"].sample()
		visibility ["All", "Friends", "Private"].sample()
		information
	end
end
