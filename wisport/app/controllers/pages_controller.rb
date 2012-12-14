require 'rubygems'
require 'google/api_client'

class PagesController < ApplicationController

  def home
    @title = "Home"
		if current_user && current_user.user_login_services.where("provider = 'google_oauth2'").first
			google = current_user.user_login_services.where("provider = 'google_oauth2'").first
			@client = Google::APIClient.new
			@client.authorization.client_id = "749658153802.apps.googleusercontent.com"
			@client.authorization.client_secret = "Xy68kv2Q1Q7ZyQNrhBqTI90G"
			@client.authorization.scope = "https://www.googleapis.com/auth/calendar"		
			@client.authorization.refresh_token = google.refresh_token
			@client.authorization.access_token = google.acces_token
			#if @client.authorization.refresh_token && @client.authorization.expired?
			  @client.authorization.fetch_access_token!
			#end
			@service = @client.discovered_api('calendar', 'v3')
			logger.debug "Services are: #{@service.methods}"
			page_token = nil
			@result = @client.execute(:api_method => @service.calendar_list.list)
		end
  end

end
