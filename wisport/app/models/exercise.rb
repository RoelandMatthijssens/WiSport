class Exercise < ActiveRecord::Base
	self.per_page = 10
	#	default_scope where("visibility IS 'Published'")
	attr_accessible :name, :type, :information, :visibility, :information_attributes, :owner,
	:distance, :hours, :minutes, :seconds, :reps, :unit

	has_one :information
	belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
	has_and_belongs_to_many :trainings_sessions
	has_many :likes, :as => :likable

	validates_presence_of :name
	validates_presence_of :type
	validates_presence_of :information
	validates_presence_of :owner

	accepts_nested_attributes_for :information, allow_destroy: true

	scope :published, where("visibility IS 'Published'")
	scope :unpublished, where("visibility IS 'Private'")
	scope :owned_by, lambda { |id| where("owner_id = ?", id) }
	scope :liked_by, lambda { |id| joins(:likes).where("likes.user_id = ?", id) }

	def self.visibility_options
		["Published", "Private"]
	end

	def self.unit_options
		["Km","Mile","Meter"]
	end

	def self.type_options
		["DistanceExercise", "RepsExercise", "TimeExercise"]
	end

	validates_inclusion_of :visibility, :in=>visibility_options, :allow_nil => false

	def self.search_by_name(name)
		if name && ! name.empty?
			where('name LIKE ?', "%#{name}%")
		else
			scoped
		end
	end
	def self.search_by_type(type)
		if type && ! type.empty?
			where('type LIKE ?', "%#{type}%")
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
	def self.select_options
		descendants.map{ |c| c.to_s }.sort
	end
	def self.inherited(child)
		child.instance_eval do
			def model_name
				Exercise.model_name
			end
		end
		super
	end


end

class DistanceExercise < Exercise
	attr_accessible :distance, :unit

	validates_presence_of :distance
	validates_presence_of :unit
end
class TimeExercise < Exercise
	attr_accessible :hours, :minutes, :seconds

	validates_presence_of :hours
	validates_presence_of :minutes
	validates_presence_of :seconds
end
class RepsExercise < Exercise
	attr_accessible :reps

	validates_presence_of :reps
end
