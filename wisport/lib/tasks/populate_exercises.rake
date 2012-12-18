namespace :db do
	task :populate_exercises, [:amount] => :environment do |t, args|
		require 'faker'
		puts "populating exercises"
		amount = args[:amount]

		Exercise.delete_all
		amount *= 3
		amount.times do
			exercise = FactoryGirl.create("exercise")
			exercise.owner.delete
			exercise.owner = User.all.sample()
			exercise.save!
		end
	end
end
