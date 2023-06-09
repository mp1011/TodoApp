require 'dotenv/load'
require_relative '../../load_settings'
require 'omniauth-google-oauth2'

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], { access_type: 'online' }    
end

OmniAuth.config.allowed_request_methods = %i[get]

