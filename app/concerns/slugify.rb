module Slugify 
#==========================================================   
  def slug
    self.username.gsub(" ", "-").downcase
  end
#==========================================================   
end