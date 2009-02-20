class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :github_user
      t.string :github_repo
      t.string :svn_path
      t.string :openid
      t.string :slug
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
