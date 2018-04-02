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
    def set_session(id)
      session[:id] = id
    end
    
    def authentic?(user, password)
      user && user.authenticate(password)
    end
    
    def current_user 
      @current_user ||= User.find(session[:id]) if session[:id].present? && User.any?
    end
    
    def logged_in?
      !!current_user
    end
#-snippets------------------------------------------------- 
    def validate_snippet(input)
      if input.gsub("xNLx", "").empty?
        
        session[:error] = messages[:empty]
        redirect "/snippets/new"
        
      end
    end
    
    def parsed(input)
      input.gsub("xNLx", "\n")
    end
#-redirects------------------------------------------------ 
    def log_in_required(error) 
      if !logged_in?
        session[:error] = messages[error]
        redirect "/login"
      end
    end
    
    def go_to_profile(username=current_user.slug)
      redirect "/#{username}/profile" 
    end
#-messages------------------------------------------------- 
    def messages
      Hash[
        :credentials, "Invalid Credentials, Please Try Again",
        :empty, "Your snippet is unhappy. Your snippet is empty. Help the snippet. Fill the snippet.",
        :login, "Must Be Logged In To Access",
        :logout, ""
        ]
    end
#---------------------------------------------------------- 
  end
#========================================================== 
end
