require_relative './config/environment'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

task :c do
  Pry.start
end

task :sass do
  system 'sass --watch app/assets/stylesheets/main.scss:public/css/main.min.css --style compressed'
end
