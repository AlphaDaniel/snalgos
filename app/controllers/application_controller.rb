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
#==========================404============================= 
  error 404 do 
    go("/404")
  end
  
  get '/404' do 
    erb :"404"
  end
#==========================root============================ 
  get '/' do 
    logged_in? ? (go_to_dashboard) : (go("/login"))
  end
#========================helpers=========================== 
  helpers do
#-user-session--------------------------------------------- 
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
#-access--------------------------------------------------- 
    def ownership_required(asset) 
      go("/404") if asset.user != current_user 
    end
#-input---------------------------------------------------- 
    def validate_snippet(input)
      if input.gsub("xNLx", "").empty?
        
        session[:alert] = alerts[:empty]
        redirect "/snippets/new"
        
      end
    end
    
    def parsed(input)
      input.gsub("xNLx", "\n")
    end
#-redirects------------------------------------------------ 
    def login_required
      go("/404") if !logged_in?
    end

    def go_to_dashboard(username=current_user.slug(current_user.username)) 
      redirect "/#{username}/dashboard" 
    end
    
    def go(route) 
      redirect route
    end
    
    def goto_signup 
      redirect "/signup"
    end
#-messages------------------------------------------------- 
    def alert(alert) 
      session[:alert] = alerts[alert]
    end
    
    def confirmation(confirmation) 
      session[:confirmation] = confirmations[confirmation]
    end

    def alerts 
      Hash[ 
        :credentials, "Invalid Credentials, Please Try Again",
        :empty, "Your snippet is unhappy. Your snippet is empty. Help the snippet. Fill the snippet.",
        :snippets, "You Have Not Created Any Snippets Yet, Click Create To Get Started",
        :name_taken, "That Username Is Taken, Please Try Another"]
    end
    
    def confirmations 
      Hash[ 
      :saved, "Saved",
      :updated, "Updated",
      :deleted, "Deleted",
      :logged_in, "You Are Already Logged In"]
    end
    
    $FOOTER_NOUNS = [
      "Love",
      "Passion",
      "Care",
      "Dedication",
      "Devotion",
      "Sweat",
      "Easter Eggs and This Is One HeHe",
      "Excellence",
      "Quality",
      "Greatness",
      "Class",
      "Distinction",
      "Creativity",
      ]
#-misc----------------------------------------------------- 
    def de_slug(slug)
      slug.gsub("-", " ")
    end
#---------------------------------------------------------- 
  end
#========================================================== 
end
