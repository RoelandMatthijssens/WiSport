namespace :db do
	desc "populates the database"

	task :populate => :environment do
		require 'faker'
		@amount = 10

		User.delete_all
		puts "--------------"
		puts "Creating Users"
		puts "--------------"
		User.create(
			:id => 1,
			:username => "Enermis",
			:email => "fulgens.ailurus@gmail.com",
			:password => "roeland1",
			:password_confirmation => "roeland1"
		)
		puts "created Enermis"
		@amount.times do
			x = FactoryGirl.create(:user)
			puts "created user #{x.username}"
		end
		Exercise.delete_all
		puts "------------------"
		puts "Creating exercises"
		puts "------------------"
		@amount.times do
			x = FactoryGirl.create(:exercise)
			puts "created exercise #{x.name}"
		end
		Information.delete_all
		puts "--------------------"
		puts "Creating information"
		puts "--------------------"
		@amount.times do
			x = FactoryGirl.create(:information)
			puts "created information #{x.media}"
		end
		TrainingsSession.delete_all
		puts "---------------------------"
		puts "Creating trainings_sessions"
		puts "---------------------------"
		@amount.times do
			x = FactoryGirl.create(:trainings_session)
			puts "created trainings_session #{x.id}"
		end
	end
end
