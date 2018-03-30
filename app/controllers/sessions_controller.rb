class SessionsController < ApplicationController 
#=========================signup============================ 
  get '/signup' do 
    go_to_profile if logged_in?
    
    erb :"users/signup"
  end
#---------------------------------------------------------- 
  post '/signup' do 
    user = User.create(params[:user])
    session[:id] = user.id
    
    go_to_profile(user.slug)
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
    
    session[:id] = user.id and go_to_profile(user.slug) if user && user.authenticate(params[:password])
    
    redirect to '/signup'
  end
#=========================logout=========================== 
  get '/logout' do 
    redirect "/login" if !logged_in?
    
    session.clear
    redirect "/"
  end
#========================================================== 
end