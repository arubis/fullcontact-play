require 'fullcontact'
require 'dotenv'

# grab the api key on testing (it's in heroku env on prod)
Dotenv.load  # defaults to grabbing from .env, which is .gitignored

# Get FullContact ready
FullContact.configure do |config|
  config.api_key = ENV['FULLCONTACT_API_KEY']
  puts "yeah man the api key is #{config.api_key}"
end

# test: input an email, output a photo URL

begin
  person = FullContact.person(email: "nonsense@nowhere.example.com")

  secondaries = Array.new

  # output primary photo URL (plus secondaries?)
  person.photos.each do |source|
    if source.is_primary?
      puts source.url
    else
      secondaries << source.url
    end
  end

rescue
  puts "Something went terribly wrong!"
end
