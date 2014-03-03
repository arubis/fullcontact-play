require 'rubygems'
require 'bundler'
Bundler.setup
require 'rack'
require 'thin'

$: << File.dirname(__FILE__)
require 'application'

run Sinatra::Application