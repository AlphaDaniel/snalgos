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
#========================================================== 
end