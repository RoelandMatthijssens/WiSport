OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "749658153802.apps.googleusercontent.com", "Xy68kv2Q1Q7ZyQNrhBqTI90G"
end