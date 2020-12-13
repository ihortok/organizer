class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect '/tasks'
    else
      slim :'/users/signup.html'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/tasks'
    else
      slim :'/users/signup.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  get '/login' do
    if !logged_in?
      slim :'users/login.html'
    else
      redirect '/tasks'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tasks'
    else
      slim :'/users/login.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  get '/users/edit' do
    if logged_in?
      set_user
      slim :'/users/edit.html'
    else
      redirect '/login'
    end
  end

  post '/users/edit' do
    params_to_update = params.reject { |_, v| v.gsub(' ', '').empty? }
    @user = User.find_by_id(session[:user_id])

    message = if @user.update(params_to_update)
                'Success'
              else
                'Something went wrong. Please try again.'
              end

    slim :'/users/edit.html', locals: { message: message }
  end

  post '/users/avatar' do
    user = User.find_by_id(session[:user_id])
    if user && params[:avatar] && params[:avatar][:filename]
      file = File.open(params[:avatar][:tempfile], 'r')
      avatar_big_path = "./public/uploads/#{user.username}_avatar_#{User::AVATAR_SIZES[:big]}#{File.extname(file)}"
      avatar_small_path = "./public/uploads/#{user.username}_avatar_#{User::AVATAR_SIZES[:small]}#{File.extname(file)}"

      avatar = MiniMagick::Image.open(file)

      avatar.resize(User::AVATAR_SIZES[:big]).write(avatar_big_path)
      avatar.resize(User::AVATAR_SIZES[:small]).write(avatar_small_path)

      user.update(avatar_path: "#{user.username}_avatar#{File.extname(file)}")

      redirect '/users/edit'
    end
  end

  get '/logout' do
    session.clear
    slim :'/index.html'
  end

  private

  def set_user
    @user = User.find_by_id(session[:user_id])
  end
end
