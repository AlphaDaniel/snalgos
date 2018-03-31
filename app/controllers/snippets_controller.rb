class SnippetsController < ApplicationController
#==========================new============================= 
  get '/snippets/new' do 
    go_to_login if !logged_in?
    
    erb :"snippets/new"
  end
#---------------------------------------------------------- 
  post '/snippets' do 
    Snippet.create(content: params[:content].gsub(",", "\n"))
    
    redirect '/snippets'
  end
#==========================index=========================== 
  get '/snippets' do 
    @snippet = Snippet.last
    
    erb :"snippets/index"
  end
#========================================================== 
end