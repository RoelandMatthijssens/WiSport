class CahngeExercicesTrainingsSessionsColumnNames < ActiveRecord::Migration
  def change
    rename_column :exercises_trainings_sessions, :exercises_id, :exercise_id
    rename_column :exercises_trainings_sessions, :trainings_sessions_id, :trainings_session_id
  end
end
