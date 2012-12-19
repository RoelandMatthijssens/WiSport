class DoExercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  belongs_to :do_session
  attr_accessible :distance, :hours, :minutes, :reps, :seconds, :visibility, :do_session_id, :exercise_id, :user_id, :done_at

	def value
		hours ||= 0
		minutes ||= 0
		seconds ||= 0
		if distance && distance != 0
			return distance
		else 
			if reps && reps != 0
				return reps
			else
				return 3600*hours+60*minutes+seconds
			end
		end
	end

	def time
		logger.debug("lala1 "+hours.inspect)
		logger.debug("lala2 "+minutes.inspect)
		logger.debug("lala3 "+seconds.inspect)
		if !hours
			mhours = 0
		else
			mhours = hours
		end
		if !minutes
			mminutes = 0
		else
			mminutes = minutes
		end
		if !seconds
			mseconds = 0
		else
			mseconds = seconds
		end
		logger.debug("lala1 "+mhours.inspect)
		logger.debug("lala2 "+mminutes.inspect)
		logger.debug("lala3 "+mseconds.inspect)
		return (3600*mhours+60*mminutes+mseconds)/600
	end

	def time_goal
		return 100
	end

	validate :user, :exercise, presence: true
end
