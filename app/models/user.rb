class User < ActiveRecord::Base 
  instances_can Slugify
#===========================================================================   
  has_many :snippets
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  has_secure_password
#=========================================================================== 
end