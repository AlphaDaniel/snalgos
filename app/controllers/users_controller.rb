class UsersController < ApplicationController
#========================profile=========================== 
  get '/:username/profile' do 
    log_in_required(:login)
    
    if current_user.username != params[:username]
      message(:ownership) and go_to_profile 
    end
    
    erb :"users/profile"
  end
#========================================================== 
end