class TasksController < ApplicationController
  get '/tasks' do
    @tasks = Task.all
    erb :'tasks/index'
  end
end
