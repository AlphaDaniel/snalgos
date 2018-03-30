class Snippet < ActiveRecord::Base
  belongs_to :user
  has_many :snippet_tags
  has_many :tags, through: :snippet_tags
end