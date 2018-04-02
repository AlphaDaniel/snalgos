class UsersController < ApplicationController
#=========================route============================ 
  get '/:username/profile' do 
    log_in_required(:login)
    
    erb :"users/profile"
  end
#========================================================== 
end