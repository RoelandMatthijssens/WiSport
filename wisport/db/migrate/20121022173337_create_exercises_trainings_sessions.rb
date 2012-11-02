class CreateExercisesTrainingsSessions < ActiveRecord::Migration
	def change
		create_table :exercises_trainings_sessions do |t|
			t.references :exercise, :null => false
			t.references :trainings_session, :null => false
		end
	end
end
