require './config/environment'
#========================================================== 
class ApplicationController < Sinatra::Base
#=======================configure========================== 
  configure do 
    enable :sessions
    set :session_secret, "snalgos_secret"
    set :public_folder, 'static'
    set :views, Proc.new { File.join(root, "../views/") }
  end
#=========================index============================ 
  get '/' do 
    erb :"index"
  end
#======================ace testing========================= 
  # this will end up being /snippets/new
  get '/ace' do
    erb :'ace'
  end
#---------------------------------------------------------- 
  post '/ace' do 
    binding.pry
    # params[:content].gsub(",", "\n")
    
    redirect '/show'
  end
#----------------------------------------------------------   
  get '/show' do 
    erb :'show'
  end
#========================helpers=========================== 

#========================================================== 
end
