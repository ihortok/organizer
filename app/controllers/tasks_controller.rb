class TasksController < ApplicationController
  get '/tasks' do
    @tasks = current_user.tasks
    slim :'tasks/index.html'
  end

  get '/tasks/new' do
    redirect '/login' unless logged_in?

    slim :'/tasks/new.html'
  end

  post '/tasks/create' do
    @task = Task.new(params.merge({ user_id: current_user.id }))

    if @task.save
      redirect '/tasks'
    else
      slim :'/tasks/new.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end
end
