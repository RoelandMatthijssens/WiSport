namespace :db do
	desc "populates the database"

	task :populate => :environment do
		require 'faker'
		@amount = 10
		ActiveRecord::Base.subclasses.each(&:delete_all)
		User.create(
			:id => 1,
			:username => "Enermis",
			:email => "fulgens.ailurus@gmail.com",
			:password => "roeland1",
			:password_confirmation => "roeland1"
		)
		FactoryGirl.factories.each do |f|
			@amount.times do 
				FactoryGirl.create(f.name)
			end
		end
	end
end
