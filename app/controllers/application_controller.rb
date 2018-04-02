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
        
        session[:message] = messages[:empty]
        redirect "/snippets/new"
        
      end
    end
    
    def validate_content(snippet, content)
      snippet.content if content.empty?
      parsed(content) if !content.empty?
    end
    
    def parsed(input)
      input.gsub("xNLx", "\n")
    end
#-redirects------------------------------------------------ 
    def log_in_required(message) 
      if !logged_in?
        session[:message] = messages[message]
        redirect "/login"
      end
    end
    
    def go_to_profile(username=current_user.slug)
      redirect "/#{username}/profile" 
    end
    
    def ownership_required(asset) 
      if asset.user != current_user 
        session[:message] = messages[:ownership]
        go_to_profile 
      end
    end
#-messages------------------------------------------------- 
    def message(message)
      session[:message] = messages[message]
    end

    def messages
      Hash[
        :credentials, "Invalid Credentials, Please Try Again",
        :empty, "Your snippet is unhappy. Your snippet is empty. Help the snippet. Fill the snippet.",
        :login, "Must Be Logged In To Access",
        :logout, "",
        :tags, "You Have Not Created Any Tags Yet",
        :snippets, "You Have Not Created Any Snippets Yet",
        :ownership, "You Do Not Have Access To That Content.",
        :saved, "Saved"
        ]
    end
#---------------------------------------------------------- 
  end
#========================================================== 
end
