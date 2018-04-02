class TagsController < ApplicationController 
#==========================index=========================== 
  get '/tags' do 
    log_in_required(:login)
    
    @tags = current_user.tags
    
    message(:tags) if @tags.empty?
    
    erb :"tags/index"
  end
#========================================================== 
end