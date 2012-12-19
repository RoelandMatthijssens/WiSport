class DoExercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  belongs_to :do_session
  attr_accessible :distance, :hours, :minutes, :reps, :seconds, :visibility, :do_session_id, :exercise_id, :user_id, :done_at

	def value
		if distance != 0
			return distance
		else 
			if reps != 0
				return reps
			else
				return 3600*hours+60*minuts+seconds
			end
		end
	end

	def time
			return (3600*hours+60*minuts+seconds/goal())*100
	end

	def time_goal
		return 100
	end

	def goal
		return 3600*exercise.hours+60*exercise.minuts+exercise.seconds
	end

	validate :user, :exercise, presence: true
end
