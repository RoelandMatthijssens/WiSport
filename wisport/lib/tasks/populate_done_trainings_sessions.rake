namespace :db do
	task :populate_done_trainings_sessions, [:amount] => :environment do |t, args|
		require 'faker'
		puts "populating done trainings_sessions"
		amount = args[:amount].to_i

		DoSession.delete_all
		DoExercise.delete_all
		User.all.each do |user|
			user.trainings_sessions.each do |trainings_session|
				done_session = DoSession.new()
				done_session.visibility = "Published"
				done_session.trainings_session_id = trainings_session.id
				done_session.remarks = Faker::Lorem.paragraphs(2)
				done_session.user = user
				done_session.done_at = Time.at(rand_in_range(2.weeks.ago.to_f, Time.now.to_f))
				done_session.trainings_session.exercises.each do |e|
					amount.times do 
						done_exercise = DoExercise.new()
						done_exercise.user = done_session.user
						done_exercise.exercise_id = e.id
						done_exercise.done_at = Time.at(rand_in_range(2.weeks.ago.to_f, Time.now.to_f))
						if done_exercise.exercise.type == "DistanceExercise"
							done_exercise.distance = rand(10)+1
							done_exercise.minutes = rand(60)
							done_exercise.seconds = rand(60)
							done_exercise.hours = 0
						end
						if done_exercise.exercise.type == "RepsExercise"
							done_exercise.reps = rand(20)+1
							done_exercise.minutes = rand(60)
							done_exercise.seconds = rand(60)
							done_exercise.hours = 0
						end
						if done_exercise.exercise.type == "TimeExercise"
							done_exercise.minutes = rand(60)
							done_exercise.seconds = rand(60)
							done_exercise.hours = 0
						end
						done_exercise.save!
						done_session.do_exercises << done_exercise
					end
				end
				done_session.save!
			end
		end
	end
end
def rand_in_range(from, to)
	rand * (to - from) + from
end
