class CreateDoExercises < ActiveRecord::Migration
  def change
    create_table :do_exercises do |t|
      t.references :user
      t.string :visibility
      t.float :distance
      t.integer :reps
      t.integer :hours
      t.integer :minutes
      t.integer :seconds
      t.references :exercise
      t.references :do_session

      t.timestamps
    end
    add_index :do_exercises, :user_id
    add_index :do_exercises, :exercise_id
    add_index :do_exercises, :do_session_id
  end
end
