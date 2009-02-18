class Project < ActiveRecord::Base
  validates_uniqueness_of :title
  
  def flickr_tag
    "rewiredstate:#{self.title}"
  end
end
