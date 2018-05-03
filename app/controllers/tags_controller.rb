class TagsController < ApplicationController 
#==========================show============================ 
  get '/tags/:name' do 
    @tag = Tag.find_by(name: de_slug(params[:name]))
    
    go("/404") if @tag.nil?
    
    ownership_required(@tag)
    
    @snippets = @tag.snippets
    
    erb :"tags/show"
  end 
#========================================================== 
end