class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '_sessionSuperSecret_'
  end

  get '/' do
    redirect '/tasks' if logged_in?

    slim :'/users/login.html', layout: :'layout.html'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def partial(name, path: '/partials', locals: {})
      Slim::Template.new("#{settings.views}#{path}/#{name}.slim").render(self, locals)
    end
  end
end
