class Event < ActiveRecord::Base
  has_event_calendar
	belongs_to :trainings_session

	def name
		return trainings_session.title
	end
end
