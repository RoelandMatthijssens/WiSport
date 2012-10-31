class CreateUserLoginServices < ActiveRecord::Migration
  def change
    create_table :user_login_services do |t|
      t.references :user
      t.string :provider
      t.string :uid
      t.string :login
      t.string :acces_token

      t.timestamps
    end
    add_index :user_login_services, :user_id
  end
end
