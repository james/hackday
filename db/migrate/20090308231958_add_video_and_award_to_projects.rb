class AddVideoAndAwardToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :bliptv_id, :string
    add_column :projects, :award, :string
  end

  def self.down
    remove_column :projects, :bliptv_id
    remove_column :projects, :award
  end
end
