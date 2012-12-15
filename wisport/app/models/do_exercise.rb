class DoExercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  belongs_to :do_session
  attr_accessible :distance, :hours, :minutes, :reps, :seconds, :visibility, :do_session_id, :exercise_id, :user_id

	validate :user, :exercise, presence: true
end
