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
    erb :"index"
  end
#========================helpers=========================== 
  helpers do
#-session-------------------------------------------------- 
    def logged_in?
      !!current_user
    end
    
    def current_user
      @current_user ||= User.find(session[:id]) if session[:id].present?
    end
#---------------------------------------------------------- 
  end
#========================================================== 
end
