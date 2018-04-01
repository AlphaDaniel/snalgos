ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :drop! do
  # delete files
  File.delete("./db/development.sqlite") and File.delete("./db/schema.rb")
  # run migration
  Rake::Task['db:migrate'].reenable
  Rake::Task['db:migrate'].invoke
  # destroy models
  User.destroy_all
  Tag.destroy_all
  Snippet.destroy_all
  SnippetTag.destroy_all
end

task :console do 
  Pry.start
end
