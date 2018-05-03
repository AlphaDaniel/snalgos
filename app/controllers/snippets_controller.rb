class SnippetsController < ApplicationController
#==========================new============================= 
  get '/snippets/new' do 
    login_required
    
    erb :"snippets/new"
  end
#---------------------------------------------------------- 
  post '/snippets/new' do 
    # get editor session
    editor_session = EditorSession.create(mode: params[:mode])
    # validate input
    validate_snippet(params[:content])
    # find or create snippet
    snippet = Snippet.find_or_create_by(title: params[:title], content: parsed(params[:content]))
    # assign editor session
    snippet.editor_session = editor_session
    # assign snippet if uniq
    current_user.snippets << snippet if !current_user.snippets.include?(snippet)
    # tag handler
    params[:tags].each do |tag_name|
      # find or create tags 
      tag = Tag.find_or_create_by(name: tag_name) if !tag_name.empty?
      # push tags to snippet
      snippet.tags << tag if !snippet.tags.include?(tag) && !tag.nil?
    end
    
    confirmation(:saved)
    redirect "/snippets/#{snippet.id}"
  end
#=========================update=========================== 
  patch '/snippets/:id/edit' do 
    # find snippet
    snippet = Snippet.find(params[:id])
    # content handler
    content = snippet.content if params[:content].empty?
    content = parsed(params[:content]) if !params[:content].empty?
    # update snippet
    snippet.update(title: params[:title], content: content)
    # target session object
    editor_session = snippet.editor_session
    # update session object's mode
    editor_session.update(mode: params[:mode])
    # tag handler
    tags = []
    params[:tags].each do |tag_name| 
      tags << tag = Tag.find_or_create_by(name: tag_name) if !tag_name.empty?
    end
    # push tags to snippet
    snippet.tags = tags
    
    confirmation(:updated)
    redirect "/snippets/#{snippet.id}"
  end
#=========================delete=========================== 
  delete '/snippets/:id/delete' do 
    snippet = Snippet.find(params[:id])
    
    snippet.destroy!
    
    confirmation(:deleted)
    
    go_to_dashboard
  end
#==========================show============================ 
  get '/snippets/:id' do 
    login_required
   
    @snippet = Snippet.find_by(id: params[:id])
    
    go("/404") if @snippet.nil? 
    
    ownership_required(@snippet) 
    
    erb :"snippets/show"
  end 
#========================================================== 
end