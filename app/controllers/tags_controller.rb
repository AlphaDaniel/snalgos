class TagsController < ApplicationController 
#==========================show============================ 
  get '/:user/tags/all' do 
    go("/404") if current_user.username != params[:user]
    
    erb :"tags/all"
  end 
  
  get '/:user/tags/:name' do 
    @tag = Tag.find_by(name: de_slug(params[:name]))
    
    go("/404") if @tag.nil?
    
    ownership_required(@tag)
    
    @snippets = @tag.snippets
    
    erb :"tags/show"
  end 
#========================================================== 
end