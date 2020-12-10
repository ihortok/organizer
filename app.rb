require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:db/organizer.sqlite3"

require './models'

get '/' do
  'Hello there!'
end

get '/tasks' do
  @tasks = Task.all
  erb :index
end
