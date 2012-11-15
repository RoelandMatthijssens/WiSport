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
		exeptions = [:image]
		FactoryGirl.factories.each do |f|
			puts "Creating #{f.name.to_s.pluralize}"
			@amount.times do 
				x = FactoryGirl.create(f.name) unless exeptions.include?(f.name)
				if x
					x = x.attributes
					x.delete "id"
					x.delete "created_at"
					x.delete "updated_at"
					x.delete "password_hash"
					x.delete "password_salt"
					puts "\t #{x}"
				end
			end
		end
	end
end
