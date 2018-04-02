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
    
    # create/assign snippet
    current_user.snippets << snippet = Snippet.create(title: params[:title], content: parsed(params[:content]))
    
    # find or create tags
    tags = Tag.find_or_create(params[:tags])
    
    # assign tags
    Tag.assign(snippet, tags)
    
    redirect '/snippets'
  end
#==========================index=========================== 
  get '/snippets' do 
    log_in_required(:login)
    
    @snippets = current_user.snippets
    
    error(:snippets) if @snippets.empty?
    
    erb :"snippets/index"
  end
#=========================update=========================== 
  patch '/snippets/:id/edit' do 
    # find snippet
    snippet = Snippet.find(params[:id])
    
    # validate content
    content = validate_content(snippet, params[:content])
    
    # update snippet
    snippet.update(title: params[:title], content: content)
    
    # find or create tags
    tags = Tag.find_or_create(params[:tags])
    
    # update snippet tags
    snippet.tags = tags if !tags.empty?
    
    error(:saved)
    
    redirect "/snippets/#{snippet.id}"
  end
#========================delete============================ 
  delete '/snippets/:id/delete' do 
    # find snippet
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