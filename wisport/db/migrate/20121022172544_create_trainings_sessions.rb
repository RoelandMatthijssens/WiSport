class CreateTrainingsSessions < ActiveRecord::Migration
  def change
    create_table :trainings_sessions do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :visibility
      t.timestamps
    end
  end
end
