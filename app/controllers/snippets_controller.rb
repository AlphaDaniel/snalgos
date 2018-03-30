class SnippetsController < ApplicationController
#======================ace testing========================= 
  # this will end up being /snippets/new
  get '/ace' do
    erb :"snippets/ace"
  end
#---------------------------------------------------------- 
  post '/ace' do 
    Snippet.create(content: params[:content].gsub(",", "\n"))
    
    redirect '/show'
  end
#----------------------------------------------------------   
  get '/show' do 
    @snippet = Snippet.first
    
    erb :"snippets/show"
  end
#========================================================== 
end