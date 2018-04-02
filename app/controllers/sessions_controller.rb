class SessionsController < ApplicationController 
#=========================signup=========================== 
  get '/signup' do 
    go_to_profile if logged_in? 
    
    erb :"users/signup"
  end
#---------------------------------------------------------- 
  post '/signup' do 
    user = User.create(params[:user])
    
    set_session(user.id)
    
    go_to_profile
  end
#=========================login============================ 
  get '/login' do 
    go_to_profile if logged_in? 
    
    erb :"users/login"
  end
#---------------------------------------------------------- 
  post '/login' do 
    go_to_profile if logged_in?
    
    user = User.find_by(params[:user])
    
    set_session(user.id) and go_to_profile(user.slug) if authentic?(user, params[:password])
    
    # else
    log_in_required(:credentials)
  end
#=========================logout=========================== 
  get '/logout' do 
    log_in_required(:logout)
    
    session.clear
    redirect "/"
  end
#========================================================== 
end