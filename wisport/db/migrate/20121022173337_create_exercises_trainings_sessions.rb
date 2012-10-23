class CreateExercisesTrainingsSessions < ActiveRecord::Migration
	def change
		create_table :exercises_trainings_sessions do |t|
			t.references :exercises, :null => false
			t.references :trainings_sessions, :null => false
		end
	end
end
