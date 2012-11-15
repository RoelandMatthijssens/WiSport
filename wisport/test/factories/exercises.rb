FactoryGirl.define do
	factory :exercise do |f|
		sequence(:name ) {|n| Faker::Lorem.word}
		type ["DistanceExercise","TimeExercise","RepsExercise"].sample()
		visibility ["Published", "Private"].sample()
		information
		f.association :owner, :factory => :user
	end
end
