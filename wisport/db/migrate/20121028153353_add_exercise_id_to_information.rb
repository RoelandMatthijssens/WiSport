class AddExerciseIdToInformation < ActiveRecord::Migration
  def change
    add_column :information, :exercise_id, :integer
  end
end
