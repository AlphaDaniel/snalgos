class User < ActiveRecord::Base 
  instances_can Slugify
#===========================================================================   
  has_many :snippets
  validates_presence_of :username, :email, :password
  has_secure_password
#=========================================================================== 
end