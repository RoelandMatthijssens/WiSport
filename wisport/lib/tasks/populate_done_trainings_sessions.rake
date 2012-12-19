namespace :db do
	task :populate_done_trainings_sessions, [:amount] => :environment do |t, args|
		require 'faker'
		puts "populating done trainings_sessions"
		amount = args[:amount].to_i

		DoSession.delete_all
		DoExercise.delete_all
		amount *= 3
		amount.times do
			done_session = DoSession.new()
			done_session.visibility = "Published"
			done_session.trainings_session_id = TrainingsSession.all.sample().id
			done_session.remarks = Faker::Lorem.paragraphs(2)
			done_session.user = User.all.sample()
			done_session.done_at = Time.at(rand_in_range(2.weeks.ago.to_f, Time.now.to_f))
			done_session.trainings_session.exercises.each do |e|
				done_exercise = DoExercise.new()
				done_exercise.user = done_session.user
				done_exercise.exercise = e
				done_exercise.done_at = Time.at(rand_in_range(2.weeks.ago.to_f, Time.now.to_f))
				done_exercise.save!
				done_session.do_exercises << done_exercise
			end
			done_session.save!
		end
	end
end
def rand_in_range(from, to)
	rand * (to - from) + from
end
