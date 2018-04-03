class UsersController < ApplicationController
#========================profile=========================== 
  get '/:username/profile' do 
    log_in_required(:login)
    
    erb :"users/profile"
  end
#========================================================== 
end