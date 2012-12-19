class Event < ActiveRecord::Base
	attr_accessible :trainings_session_id, :visibility, :start_at, :end_at, :color, :trainings_session, :description, :address, :latitude, :longitude
  has_event_calendar
	geocoded_by :address
	belongs_to :trainings_session
	belongs_to :user
	after_validation :geocode

	validates_presence_of :trainings_session, :visibility, :start_at, :end_at, :color
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
