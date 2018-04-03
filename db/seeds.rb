# DATA
users = [
  {username: "user1", email: "e@1.com", password: "12345"},
  {username: "user2", email: "e@2.com", password: "12345"},
  {username: "user3", email: "e@3.com", password: "12345"}
] 

snippets = [
  {title: "title1", content: "def something1\n\nend"},
  {title: "title2", content: "def something2\n\nend"},
  {title: "title3", content: "def something3\n\nend"}
]

tags = [
  {name: "tag1"},
  {name: "tag2"},
  {name: "tag3"}
]

# CREATE
users.each{|u| User.create(u)}
# snippets.each{|u| Snippet.create(u)}
# tags.each{|u| Tag.create(u)}


# ASSIGN
# Snippet.all.each{|s| User.first.snippets << s}
# Tag.all.each{|t| Snippet.first.tags << t}
 