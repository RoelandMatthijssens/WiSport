class DoExercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  belongs_to :do_session
  attr_accessible :distance, :hours, :minutes, :reps, :seconds, :visibility, :do_session_id, :exercise_id, :user_id, :done_at

	def value
		if distance && distance != 0
			return distance
		else 
			if reps && reps != 0
				return reps
			else if (minutes && hours && seconds)
					return 3600*hours+60*minutes+seconds
				else
					return 0
				end
			end
		end
	end

	def time
		#if !hours || !minutes || !seconds
			return 0
		#else
		#	return (3600*hours+60*minutes+seconds/goal())*100
		#end
	end

	def time_goal
		return 100
	end

	def goal
		#
		#return 3600*exercise.hours+60*exercise.minutes+exercise.seconds
	end

	validate :user, :exercise, presence: true
end
