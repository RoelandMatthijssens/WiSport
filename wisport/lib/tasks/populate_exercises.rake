namespace :db do
	task :populate_exercises, [:amount] => :environment do |t, args|
		require 'faker'
		puts "populating exercises"
		amount = args[:amount].to_i

		Exercise.delete_all
		amount *= 3
		amount.times do
			exercise = Exercise.new()
			exercise.name = Faker::Lorem.word + " " +Faker::Lorem.word
			exercise.visibility = "Published"
			exercise.type = Exercise.type_options.sample
			if exercise.type == "DistanceExercise"
				exercise.unit = Exercise.unit_options.sample
				exercise.distance = rand(10)+1
			end
			if exercise.type == "TimeExercise"
				exercise.seconds = rand(60)
				exercise.minutes = rand(60)
				exercise.hours = 0
			end
			if exercise.type == "RepsExercise"
				exercise.reps = rand(20)+1
			end
			exercise.owner = User.all.sample()
			i = Information.new()
			i.description = Faker::Lorem.paragraphs(2)
			i.save!
			exercise.information = i
			exercise.save!
		end
	end
end
