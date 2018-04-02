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
#==========================show============================ 
  get '/snippets/:id' do 
    log_in_required(:login)
    
    @snippet = Snippet.find(params[:id])
    
    ownership_required(@snippet) 
    
    erb :"snippets/show"
  end 
#========================================================== 
end