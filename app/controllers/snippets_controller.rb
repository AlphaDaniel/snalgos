class SnippetsController < ApplicationController
#==========================new============================= 
  get '/snippets/new' do 
    go_to_login if !logged_in?
    
    erb :"snippets/new"
  end
#---------------------------------------------------------- 
  post '/snippets/new' do 
    # input validation
    if params[:content].gsub(",", "").empty?
      
      session[:error] = messages[:empty]
      redirect "/snippets/new"
    end
    
    # snippet creation + add to user's snippets
    current_user.snippets << snippet = Snippet.create(content: params[:content].gsub(",", "\n"))
    
    # find or create tags + add to snippet's tags
    params[:tags].each do |tag_name| 
      snippet.tags << Tag.find_or_create_by(name: tag_name)
    end
    
    redirect '/snippets'
  end
#==========================index=========================== 
  get '/snippets' do 
    @snippet = Snippet.last
    
    erb :"snippets/index"
  end
#========================================================== 
end