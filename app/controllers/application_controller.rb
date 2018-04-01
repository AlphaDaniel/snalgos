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
      if input.gsub(",", "").empty?
        
        session[:error] = messages[:empty]
        redirect "/snippets/new"
        
      end
    end
    
    def parsed(input)
      input.gsub(",", "\n")
    end
#-redirects------------------------------------------------ 
    def go_to_login
      redirect "/login"
    end
    
    def go_to_profile(username=current_user.slug)
      redirect "/#{username}/profile" 
    end
#-messages------------------------------------------------- 
    def messages
      Hash[
        :credentials, "Invalid Credentials, Please Try Again",
        :empty, "Your snippet is unhappy. Your snippet is empty. Help the snippet. Fill the snippet."
        ]
    end
#---------------------------------------------------------- 
  end
#========================================================== 
end
