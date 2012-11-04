OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "749658153802.apps.googleusercontent.com", "Xy68kv2Q1Q7ZyQNrhBqTI90G"
  provider :facebook, "170234746450746", "c703a21ffcd8b02b5d7a76f5bd83a842"
  provider :twitter, "rS4GOeHJEUIQ0hKQCU6og", "QAdu1ag8EDxCqMSuP1dli7ov0o8KrvaMuXAux5uoV8"
end
