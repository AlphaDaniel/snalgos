class SnippetsController < ApplicationController
#==========================new============================= 
  get '/snippets/new' do 
    log_in_required(:login)
    
    erb :"snippets/new"
  end
#---------------------------------------------------------- 
  post '/snippets/new' do 
    # validate input
    validate_snippet(params[:content])
    
    # find or create snippet
    snippet = Snippet.find_or_create_by(title: params[:title], content: parsed(params[:content]))
    
    # assign snippet if uniq
    current_user.snippets << snippet if !current_user.snippets.include?(snippet)
    
    # find or create + assign tags
    params[:tags].each do |tag_name|
      
      tag = Tag.find_or_create_by(name: tag_name) if !tag_name.empty?
      
      snippet.tags << tag if !snippet.tags.include?(tag) && !tag.nil?
      
    end
    
    message(:saved)
    redirect "/snippets/#{snippet.id}"
  end
#==========================index=========================== 
  get '/snippets' do 
    log_in_required(:login)
    
    @snippets = current_user.snippets
    
    message(:snippets) if @snippets.empty?
    
    erb :"snippets/index"
  end
#=========================update=========================== 
  patch '/snippets/:id/edit' do 
    snippet = Snippet.find(params[:id])
    
    # validate content
    content = snippet.content if params[:content].empty?
    content = parsed(params[:content]) if !params[:content].empty?
    
    # update snippet
    snippet.update(title: params[:title], content: content)
    
    # find or create + assign tags
    tags = []
    params[:tags].each do |tag_name|
      
      tags << tag = Tag.find_or_create_by(name: tag_name) if !tag_name.empty?
      
    end
    
    snippet.tags = tags 
    
    message(:saved)
    redirect "/snippets/#{snippet.id}"
  end
#=========================delete=========================== 
  delete '/snippets/:id/delete' do 
    snippet = Snippet.find(params[:id])
    
    snippet.destroy!
    
    go_to_profile
  end
#==========================show============================ 
  get '/snippets/:id' do 
    log_in_required(:login)
    
    @snippet = Snippet.find(params[:id])
    
    ownership_required(@snippet) 
    
    erb :"snippets/show"
  end 
#========================================================== 
end