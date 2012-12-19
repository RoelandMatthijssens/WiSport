class TrainingsSession < ActiveRecord::Base
	attr_accessible :exercise_ids, :owner, :title, :description, :visibility

	belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
	validates_presence_of :owner, :title, :visibility
	has_and_belongs_to_many :exercises
	has_many :likes, :as => :likable
	has_many :events
	
	scope :published, where("trainings_sessions.visibility IS 'Published'")
	scope :unpublished, where("trainings_sessions.visibility IS 'Private'")
	scope :owned_by, lambda { |id| where("trainings_sessions.user_id = ?", id) }
	scope :liked_by, lambda { |id| joins(:likes).where("likes.user_id = ?", id) }

	def self.visibility_options
		["Published", "Private"]
	end
	
	validates_inclusion_of :visibility, :in=>visibility_options, :allow_nil => false
	
	def self.search_by_title(title)
		if title && ! title.empty?
			where('title LIKE ?', "%#{title}%")
		else
			scoped
		end
	end 
	def self.search_by_description_and_exercise(description)
		if description && ! description.empty?
			joins(:exercises).where('trainings_sessions.description LIKE ? OR exercises.name LIKE ?', "%#{description}%", "%#{description}%")
		else
			scoped
		end
	end
	def self.search_by_exercise(exercise)
		if exercise && ! exercise.empty?
			joins(:exercises).where('exercises.name LIKE ?', "%#{exercise}%")
		else
			scoped
		end
	end
	def self.search_by_owner(username)
		if username && ! username.empty?
			joins(:owner).where('users.username LIKE ?', "%#{username}%")
		else
			scoped
		end
	end
end
