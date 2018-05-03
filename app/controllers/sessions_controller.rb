class SessionsController < ApplicationController 
#=========================signup=========================== 
  get '/signup' do 
    confirmation(:logged_in) and go_to_dashboard if logged_in?
    
    erb :"users/signup"
  end
#---------------------------------------------------------- 
  post '/signup' do 
    alert(:name_taken) and go("/signup") if User.find_by(username: params[:user][:username])
    
    user = User.create(params[:user])
    
    set_session(user.id) and go_to_dashboard
  end
#=========================login============================ 
  get '/login' do 
    confirmation(:logged_in) and go_to_dashboard if logged_in? 
    
    erb :"users/login"
  end
#---------------------------------------------------------- 
  post '/login' do 
    user = User.find_by(params[:user])
    
    set_session(user.id) and go_to_dashboard if authentic?(user, params[:password])

    alert(:credentials) and go("/login") if !logged_in?
  end
#=========================logout=========================== 
  get '/logout' do 
    login_required
    
    session.clear and go("/")
  end
#========================================================== 
end