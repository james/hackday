class AddTwitterAndCodebaseToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :code_url, :string
    add_column :projects, :twitter_username, :string
  end

  def self.down
    remove_column :projects, :code_url
    remove_column :projects, :twitter_username
  end
end
