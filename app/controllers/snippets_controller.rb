class SnippetsController < ApplicationController
#==========================new============================= 
  get '/snippets/new' do 
    go_to_login if !logged_in?
    
    erb :"snippets/new"
  end
#---------------------------------------------------------- 
  post '/snippets/new' do 
    # validate input
    if params[:content].gsub(",", "").empty?
      
      session[:error] = messages[:empty]
      redirect "/snippets/new"
    end
    
    # create/assign snippet
    current_user.snippets << snippet = Snippet.create(content: params[:content].gsub(",", "\n"))
    
    # find or create tags
    tags = Tag.find_or_create(params[:tags])
    # assign tags
    Tag.assign(snippet, tags)
    
    redirect '/snippets'
  end
#==========================index=========================== 
  get '/snippets' do 
    @snippet = Snippet.last
    
    erb :"snippets/index"
  end
#========================================================== 
end