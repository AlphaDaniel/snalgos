class Tag < ActiveRecord::Base 
  instances_can Slugify
#========================================================== 
  has_many :snippet_tags
  has_many :snippets, through: :snippet_tags
  
  validates_presence_of :name
#========================================================== 
  def user
    self.snippets.first.user unless self.snippets.empty?
  end
#========================================================== 
end