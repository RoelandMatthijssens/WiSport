namespace :db do
	task :populate_events, [:amount] => :environment do |t, args|
		require 'faker'
		puts "populating events"
		amount = args[:amount]

		Event.delete_all
		amount *= 3
		amount.times do
			event = Event.new()
			event.visibility = "Published"
			event.trainings_session_id = TrainingsSession.all.sample().id
			event.description = Faker::Lorem.paragraph
			event.user = User.all.sample()
			event.start_at = Time.at(rand_in_range(2.weeks.ago.to_f, Time.now.to_f))
			event.end_at = event.start_at
			event.color = Event.color_options.sample()
			event.save!
		end
	end
end
def rand_in_range(from, to)
	rand * (to - from) + from
end
