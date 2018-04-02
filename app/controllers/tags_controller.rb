class TagsController < ApplicationController 
#==========================index=========================== 
  get '/tags' do 
    log_in_required(:login)
    
    @tags = current_user.tags
    
    error(:tags) if @tags.empty?
    
    erb :"tags/index"
  end
#========================================================== 
end