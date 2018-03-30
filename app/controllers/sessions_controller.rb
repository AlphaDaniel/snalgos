class SessionsController < ApplicationController 
#=========================signup============================ 
  get '/signup' do 
    redirect "/#{current_user.slug}/profile" if logged_in?
    
    erb :"users/signup"
  end
#---------------------------------------------------------- 
  post '/signup' do 
    user = User.create(params[:user])
    session[:id] = user.id
    
    redirect "/#{user.slug}/profile"
  end

#=========================login============================ 
  get '/login' do
    erb :"users/login"
  end
#---------------------------------------------------------- 
  post '/login' do 
    redirect "/#{current_user.slug}/profile" if logged_in?
    
    user = User.find_by(params[:user])
    
    session[:id] = user.id and redirect "/#{user.slug}/profile" if user && user.authenticate(params[:password])
    
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