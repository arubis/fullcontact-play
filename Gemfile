ruby '2.1.0'
source 'https://rubygems.org'

gem "rack", '~>1.0'
gem "thin"
gem "sinatra"
gem "kramdown"
gem "haml"
gem "sass"
# gem 'heroku' # so okay we'll just use the toolbelt, le sigh -- this screws up deps now
gem 'compass'
gem "bootstrap-sass"
gem "foreman"
gem "multi_json", "~>1.0"

gem 'dotenv' # load environment variables from .env, does nothing on prod

# i mean this is kind of the point of it all right?
gem "fullcontact"

group :test, :development do
  gem "sinatra-reloader"
  gem 'rspec'
  gem 'rack-test'
  gem 'guard-rspec'
  gem 'spork'
end

group :test do
  gem 'growl', '1.0.3'
end
