ENV['SINATRA_ENV'] ||= 'development'

require 'sinatra'
require 'bundler'
require 'dotenv'

Dotenv.load
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/organizer.sqlite3'
  )
end

require_all 'app'
