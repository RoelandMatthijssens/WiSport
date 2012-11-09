FactoryGirl.define do
	factory :exercise do |f|
		sequence(:name ) {|n| Faker::Lorem.word}
		sequence(:title) {|n| Faker::Lorem.sentence}
		type ["DistanceExercise","TimeExercise","RepsExercise"].sample()
		visibility ["All", "Friends", "Private"].sample()
		information
		f.association :owner, :factory => :user
	end
end
