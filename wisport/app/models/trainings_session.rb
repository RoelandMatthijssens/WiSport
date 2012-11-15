class TrainingsSession < ActiveRecord::Base
	attr_accessible :exercise_ids, :owner, :title, :description, :visibility

	belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
	validates_presence_of :owner, :title, :visibility
	has_and_belongs_to_many :exercises

	def self.published
		where("visibility IS 'Published'")
	end

	def self.visibility_options
		["Published", "Private"]
	end
	
	validates_inclusion_of :visibility, :in=>visibility_options, :allow_nil => false
end
