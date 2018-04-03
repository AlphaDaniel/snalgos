class Tag < ActiveRecord::Base 
#==============================Properties=============================== 
  has_many :snippet_tags
  has_many :snippets, through: :snippet_tags
  validates_presence_of :name
#=============================Class Methods============================= 
  # def self.find_or_create(tags) 
    
  # end
#======================================================================= 
end