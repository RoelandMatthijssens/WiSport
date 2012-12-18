namespace :db do
	task :populate_trainings_sessions, [:amount] => :environment do |t, args|
		require 'faker'
		puts "populating trainings sessions"
		amount = args[:amount]

		TrainingsSession.delete_all
		amount*=2
		amount.times do
			trainings_session = TrainingsSession.new()
			trainings_session.title = Faker::Lorem.words(3)
			trainings_session.description = Faker::Lorem.paragraph
			trainings_session.visibility = "Published"
			trainings_session.owner = User.all.sample()
			3.times do
				trainings_session.exercises << Exercise.all.sample()
			end
			trainings_session.save!
		end
	end
end
