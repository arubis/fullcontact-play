require 'fullcontact'
require 'dotenv'
require 'sinatra'

# grab the api key on testing (it's in heroku env on prod)
Dotenv.load  # defaults to grabbing from .env, which is .gitignored

# Get FullContact ready
FullContact.configure do |config|
  config.api_key = ENV['FULLCONTACT_API_KEY']
  puts "yeah man the api key is #{config.api_key}"
end

# test: input an email, output name and pictures

get '/' do
  "This would be a great place for an email form"
end

get '/:email' do
  "Hello, world! Maybe someday I'll tell you about #{params[:email]}!"
end

def email_to_person(email)
  begin
    FullContact.person(email: email)
  rescue
    puts "Something went terribly wrong!"
  end
end

def email_to_pictures(email)


  # separate primary photo from secondaries
  secondaries = Array.new
  person.photos.each do |source|
    if source.is_primary?
      primary = source.url
    else
      secondaries << source.url
    end
  end

  # hand back some pictures to the caller
  { primary: primary, secondaries: secondaries }

end