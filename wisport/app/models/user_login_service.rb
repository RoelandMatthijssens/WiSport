class UserLoginService < ActiveRecord::Base
  belongs_to :user
  attr_accessible :acces_token, :login, :provider, :uid, :refresh_token, :token_expiration, :image, :profile_link
end
