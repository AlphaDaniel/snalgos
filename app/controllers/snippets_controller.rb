class SnippetsController < ApplicationController
#==========================new============================= 
  get '/snippets/new' do 
    go_to_login if !logged_in?
    
    erb :"snippets/new"
  end
#---------------------------------------------------------- 
  post '/snippets/new' do 
    # validate input
    validate_snippet(params[:content])
    
    # create/assign snippet
    current_user.snippets << snippet = Snippet.create(content: parsed(params[:content]))
    
    # find or create tags
    tags = Tag.find_or_create(params[:tags])
    
    # assign tags
    Tag.assign(snippet, tags)
    
    redirect '/snippets'
  end
#==========================index=========================== 
  get '/snippets' do 
    go_to_login if !logged_in?
    
    @snippets = current_user.snippets
    
    erb :"snippets/index"
  end
#========================================================== 
end