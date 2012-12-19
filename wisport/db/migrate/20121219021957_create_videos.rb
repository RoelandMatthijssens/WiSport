class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.references :information

      t.timestamps
    end
    add_index :videos, :information_id
  end
end
