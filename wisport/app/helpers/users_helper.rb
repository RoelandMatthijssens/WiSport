module UsersHelper
	def profile_picture user
		if (not user.user_login_services.empty?) && user.user_login_services.first.image
			user.user_login_services.first.image
		else
			avatar_url(user)
		end 
	end
	def avatar_url user
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=48&"
	end
end
