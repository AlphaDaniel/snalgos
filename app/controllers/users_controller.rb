class UsersController < ApplicationController
#=======================dashboard========================== 
  get '/:username/dashboard' do 
    go("/404") if current_user.username != params[:username]
    
    @snippets = current_user.snippets
    
    alert(:snippets) if @snippets.empty?
    
    erb :"users/dashboard"
  end
#========================================================== 
end

