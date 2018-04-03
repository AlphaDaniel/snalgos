# DATA
users = [
  {username: "user1", email: "e@1.com", password: "12345"},
  {username: "user2", email: "e@2.com", password: "12345"},
  {username: "user3", email: "e@3.com", password: "12345"}
] 

# CREATE
users.each{|u| User.create(u)}
 