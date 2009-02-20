class Project < ActiveRecord::Base
  validates_uniqueness_of :title
  
  has_slug :title, :slug, :always_update => true
  def to_param
    slug
  end
  
  def flickr_tag
    "rewiredstate:#{self.title}"
  end
end
