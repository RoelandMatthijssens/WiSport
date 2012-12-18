FactoryGirl.define do
	factory :exercise do |f|
		sequence(:name ) {|n| Faker::Lorem.word}
		sequence(:type) { ["DistanceExercise","TimeExercise","RepsExercise"].sample()}
		visibility "Published"
		information
		f.association :owner, :factory => :user
	end
end
