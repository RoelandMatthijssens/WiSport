class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  has_many :user_login_services

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
  
  def self.from_omniauth(auth)
    user = joins(:user_login_services).where("user_login_services.provider = ? AND user_login_services.uid = ?", auth["provider"], auth["uid"]).first
    if user
      user.set_service(auth)
      user
    else
      create_from_omniauth(auth)
    end
  end
  
  def set_service(auth)
    s = user_login_services.where("provider = ?", auth["provider"])
    if s.empty?
      user_login_services.new( provider: auth["provider"], uid: auth["uid"], 
      login: auth["info"]["email"], acces_token: auth["credentials"]["token"],
      refresh_token: auth["credentials"]["refresh_token"],
      token_expiration: Time.at(auth["credentials"]["expires_at"].to_i),
      image: auth["info"]["image"],
      profile_link: auth["extra"]["raw_info"]["link"]
      )
    else
      s.first.update_attributes!( acces_token: auth["credentials"]["token"],
      refresh_token: auth["credentials"]["refresh_token"],
      token_expiration: Time.at(auth["credentials"]["expires_at"].to_i),
      image: auth["info"]["image"],
      profile_link: auth["extra"]["raw_info"]["link"]
      )
    end
  end  

  def self.create_from_omniauth(auth)
    new_user = new do |user|
      user.username = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.user_login_services.new( provider: auth["provider"], uid: auth["uid"], 
      login: auth["info"]["email"], acces_token: auth["credentials"]["token"],
      refresh_token: auth["credentials"]["refresh_token"],
      token_expiration: Time.at(auth["credentials"]["expires_at"].to_i),
      image: auth["info"]["image"],
      profile_link: auth["extra"]["raw_info"]["link"]
      )
    end
    new_user.save(:validate => false)
    new_user
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
