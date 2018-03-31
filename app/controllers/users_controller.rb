class UsersController < ApplicationController
#=========================route============================ 
  get '/:username/profile' do 
    erb :"users/profile"
  end
#---------------------------------------------------------- 
  post '/' do 
    
    redirect ""
  end
#========================================================== 
end