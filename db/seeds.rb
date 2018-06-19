User.destroy_all
Snippet.destroy_all
Tag.destroy_all
SnippetTag.destroy_all

# USERS
users = [
  {username: 'guest', email: 'e@1.com', password: '12345'},
  {username: 'dev', email: 'e@2.com', password: '12345'}
] 

# CREATE USERS
users.each {|u| User.create(u)}

# CREATE/ASSOCIATE SNIPPETS, SESSION, & TAGS
a = 0
20.times do
  snippet = Snippet.create(title: "Dummy Snippet #{a+1}", content: "def something\n  \nend")
  snippet.editor_session = EditorSession.create(mode: "ace/mode/ruby")
  
  snippet.tags << Tag.new(name: "Dummy Tag #{a+1}")
  
  User.second.snippets << snippet
  a += 1
end