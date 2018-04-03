class TagsController < ApplicationController 
#==========================index=========================== 
  get '/tags' do 
    log_in_required(:login)
    
    message(:tags) if current_user.tags.empty?
    
    erb :"tags/index"
  end
#========================================================== 
end