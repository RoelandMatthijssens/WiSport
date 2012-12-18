class CreateDoSessions < ActiveRecord::Migration
  def change
    create_table :do_sessions do |t|
      t.references :user
      t.string :visibility
      t.text :remarks
      t.references :trainings_session
			t.datetime :done_at

      t.timestamps
    end
    add_index :do_sessions, :user_id
    add_index :do_sessions, :trainings_session_id
  end
end
