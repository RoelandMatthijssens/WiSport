class AddImageAndRefreshTokenAndTokenExpirationAndProfileLinkToUserLoginServices < ActiveRecord::Migration
  def change
    add_column :user_login_services, :image, :string
    add_column :user_login_services, :refresh_token, :string
    add_column :user_login_services, :token_expiration, :datetime
    add_column :user_login_services, :profile_link, :string
  end
end
