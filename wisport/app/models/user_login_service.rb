class UserLoginService < ActiveRecord::Base
  belongs_to :user
  attr_accessible :acces_token, :login, :provider, :uid
end
