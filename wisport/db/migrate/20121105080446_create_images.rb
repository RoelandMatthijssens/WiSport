class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :original
      t.string :imagur_page
      t.string :delete_page
      t.string :small_square
      t.string :large_thumbnail
      t.string :delete_hash
      t.references :information

      t.timestamps
    end
  end
end
