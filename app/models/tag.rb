class Tag < ActiveRecord::Base
  has_many :snippet_tags
  has_many :snippets, through: :snippet_tags
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end