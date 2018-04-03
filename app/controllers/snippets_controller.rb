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
      
      tag = Tag.find_or_create_by(name: params[:tags][0]) if !params[:tags][0].empty?
      
      snippet.tags << tag if !snippet.tags.include?(tag)
      
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
    content = validate_content(snippet, params[:content])
    
    # update snippet
    snippet.update(title: params[:title], content: content)
    
    # find or create + assign tags
    params[:tags].each do |tag_name|
      
      tag = Tag.find_or_create_by(name: params[:tags][0]) if !params[:tags][0].empty?
      
      snippet.tags << tag if !snippet.tags.include?(tag)
      
    end
    
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