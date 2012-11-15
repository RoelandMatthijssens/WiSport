FactoryGirl.define do
	factory :trainings_session do |f|
		sequence(:title ) {|n| Faker::Lorem.word}
		visibility ["Published", "Private"].sample()
		description Faker::Lorem.paragraph
		f.association :owner, :factory => :user
	end
end
