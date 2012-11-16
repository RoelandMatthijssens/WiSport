FactoryGirl.define do
	factory :trainings_session do |f|
		sequence(:title ) {Faker::Lorem.word}
		visibility ["Published", "Private"].sample()
		sequence(:description) {Faker::Lorem.paragraph}
		f.association :owner, :factory => :user
	end
end
