class Event < ActiveRecord::Base
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
	validates_inclusion_of :visibility, :in => visibility_options, :allow_nil => false
end
