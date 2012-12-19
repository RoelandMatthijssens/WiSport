namespace :db do
	desc "populates the database"

	task :populate, [:amount] => :environment do |t, args|
		amount = args[:amount].to_i
		Rake::Task["db:populate_users"].invoke(amount)
		Rake::Task["db:populate_exercises"].invoke(amount)
		Rake::Task["db:populate_trainings_sessions"].invoke(amount)
		Rake::Task["db:populate_events"].invoke(amount)
		Rake::Task["db:populate_done_trainings_sessions"].invoke(amount)
	end
end
