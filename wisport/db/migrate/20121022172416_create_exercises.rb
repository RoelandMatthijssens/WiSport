class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :title
      t.string :typee
      t.integer :user_id
      t.string  :visibility
	
      t.references :information

      t.timestamps
    end
  end
end
