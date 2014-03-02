require 'fullcontact'
require 'dotenv'

# grab the api key on testing (it's in heroku env on prod)
Dotenv.load  # defaults to grabbing from .env, which is .gitignored

# Get FullContact ready
FullContact.configure do |config|
  config.api_key = ENV['FULLCONTACT_API_KEY']
  puts "yeah man the api key is #{config.api_key}"
end


