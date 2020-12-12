class TasksController < ApplicationController
  get '/tasks' do
    @tasks = Task.all
    slim :'tasks/index.html'
  end
end
