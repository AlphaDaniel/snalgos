class UsersController < ApplicationController
#=========================route============================ 
  get '/:username/profile' do 
    log_in_required(:login)
    
    erb :"users/profile"
  end
#---------------------------------------------------------- 
  post '/' do 
    
    redirect ""
  end
#========================================================== 
end