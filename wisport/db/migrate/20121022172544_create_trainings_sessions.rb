class CreateTrainingsSessions < ActiveRecord::Migration
  def change
    create_table :trainings_sessions do |t|

      t.timestamps
    end
  end
end
