class TasksController < ApplicationController
  get '/tasks' do
    redirect '/login' unless logged_in?

    @tasks = current_user.tasks
    slim :'tasks/index.html', layout: :'layout.html'
  end

  get '/tasks/new' do
    redirect '/login' unless logged_in?

    slim :'/tasks/new.html', layout: :'layout.html'
  end

  post '/tasks/create' do
    @task = Task.new(params.merge({ user_id: current_user.id }))

    if @task.save
      redirect '/tasks'
    else
      slim :'/tasks/new.html', layout: :'layout.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  post '/tasks/destroy' do
    @task = Task.find_by(id: params[:task_id])
    @task.destroy

    redirect '/tasks'
  end
end
