namespace :db do
	desc "populates the database"

	task :populate_users, [:amount] => :environment do |t, args|
		require 'faker'
		puts "Populating users"
		amount = args[:amount]

		User.delete_all
		x = User.new do |u|
			u.username = "Enermis"
			u.email = "fulgens.ailurus@gmail.com"
			u.password = "roeland1"
			u.password_confirmation = "roeland1"
		end.save!
		amount *= 1
		amount.times do
			user = FactoryGirl.create("user")
			user.save!
		end

	end
end
