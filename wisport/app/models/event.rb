class Event < ActiveRecord::Base
	attr_accessible :trainings_session_id, :visibility, :start_at, :end_at, :color
  has_event_calendar
	belongs_to :trainings_session
	belongs_to :user

	validates_presence_of :trainings_session, :visibility
	scope :published, where("visibility is 'Published'")

	def name
		return trainings_session.title
	end

	def self.visibility_options
		["Published","Private"]
	end
	def self.color_options
		["Maroon","Orange","Gold","Olive","Pink","LightSteelBlue"]
	end
	validates_inclusion_of :visibility, :in => visibility_options, :allow_nil => false
end
