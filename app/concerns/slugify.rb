module Slugify 
  
  def slug(name)
    name.gsub(" ", "-")
  end
  
end