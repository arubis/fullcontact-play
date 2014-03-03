require 'fullcontact'
require 'dotenv'
require 'sinatra'
require 'sinatra/reloader' if development?

# configure sinatra's rendering
set :haml, :format => :html5, :layout => true
   # n.b. :layout => true renders haml docs through layout.haml if it exists
   # and can be redirected to another symbol for a different layout
   # or "false" for none

base_name = "AboutSomeGuy: Personal Profiles for Whoever"

# grab the api key on testing (it's in heroku env on prod)
Dotenv.load  # defaults to grabbing from .env, which is .gitignored

# Get FullContact ready
FullContact.configure do |config|
  config.api_key = ENV['FULLCONTACT_API_KEY']
  puts "yeah man the api key is #{config.api_key}" # shows right up in the server logs
end

# test: input an email, output name and pictures

get '/' do
  haml :landing, :locals => { title: base_name }
end

get '/e' do
  # "Hello, world! Maybe someday I'll tell you about #{params[:email]}!"
  # haml :bizcard, :locals => { title: "Profile pictures for #{params[:email]}",
  #                             pictures: email_to_pictures(params[:email])      }
  @email = params[:e]
  @elements = email_to_elements(@email)
  @pictures = { primary: @elements[:primary], secondaries: @elements[:secondaries] }
  @name = @elements[:name]

  haml :bizcard, :locals => { title: "#{@name} | #{base_name}", email: @email, pictures: @pictures, name: @name }
end

post '/e' do
  @email = params[:e]
  @pictures = email_to_elements(@email)
  redirect 
end

get '/nope' do
  status 500
  @email = params[:e]
  "Couldn't find anything for #{@email}, sorry!"
end

def email_to_person(email)
  begin
    @person = FullContact.person(email: email)
  rescue
    puts "Something went terribly wrong!"
    redirect to("/nope?e=#{email}")
  end
end

def email_to_elements(email)
  person = email_to_person(email)

  @fullname = person.contact_info.full_name

  @secondaries = Array.new
  person.photos.each do |source|
    if source.is_primary?
      @primary = source.url
    else
      @secondaries << source.url
    end
  end

  # hand back some pictures to the caller
  { name: @fullname, primary: @primary, secondaries: @secondaries }

end