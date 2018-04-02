class Tag < ActiveRecord::Base 
#==============================Properties=============================== 
  has_many :snippet_tags
  has_many :snippets, through: :snippet_tags
  validates_presence_of :name
#=============================Class Methods============================= 
  # tag finder/creator
  def self.find_or_create(tags) 
    col = [].tap do |col|
      tags.each do |tag_name| 
        col << Tag.find_or_create_by(name: tag_name)
      end
    end
  end
  # tag assigner
  def self.assign(snippet, tags) 
    tags.each{|tag| snippet.tags << tag}
  end
#======================================================================= 
end