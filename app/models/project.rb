class Project < ActiveRecord::Base
  validates_uniqueness_of :title
  validates_presence_of :openid, :title
  has_slug :title, :slug, :always_update => true
  def to_param
    slug
  end
  
  def flickr_tag
    %{rewiredstate:project="#{self.slug}"}
  end
  def flickr_url
    %{http://flickr.com/photos/tags/#{flickr_tag}}
  end
  
  def github_json_path
    "http://github.com/api/v1/json/coupde/ruminant/commits"
  end
end
