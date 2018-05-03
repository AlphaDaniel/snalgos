class Snippet < ActiveRecord::Base 
#========================================================== 
  belongs_to :user
  has_many :snippet_tags
  has_many :tags, -> { distinct }, through: :snippet_tags
  has_one :editor_session
  
  validates_presence_of :title, :content
#========================================================== 
end