class SnippetTag < ActiveRecord::Base
  belongs_to :snippet
  belongs_to :tag
end