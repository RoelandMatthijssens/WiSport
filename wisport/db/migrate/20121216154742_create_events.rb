class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :trainings_session
      t.references :user
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day, :default => true
      t.string :color
      t.string :visibility
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
