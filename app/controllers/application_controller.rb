require './config/environment'
#========================================================== 
class ApplicationController < Sinatra::Base
#=======================configure========================== 
  configure do 
    enable :sessions
    set :session_secret, "snalgos_secret"
    set :public_folder, 'static'
    set :views, Proc.new { File.join(root, "../views/") }
  end
#=========================index============================ 
  get '/' do 
    erb :"home"
  end
#========================helpers=========================== 
  helpers do
#-session-------------------------------------------------- 
    def current_user
      @current_user ||= User.find(session[:id]) if session[:id].present?
    end
    
    def logged_in?
      !!current_user
    end
#-redirects------------------------------------------------     
    def go_to_profile(username=current_user.slug)
      redirect "/#{username}/profile" 
    end
#---------------------------------------------------------- 
  end
#========================================================== 
end
