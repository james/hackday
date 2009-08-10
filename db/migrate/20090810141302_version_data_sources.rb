class VersionDataSources < ActiveRecord::Migration
  def self.up
    create_table :data_source_versions do |t|
      t.integer :data_source_id
      t.integer :version
      t.string :title
      t.string :link
      t.text :description
      t.string :category
      t.datetime :deleted_at

      t.timestamps
    end
    add_column :data_sources, :version, :integer, :default=>1
    add_column :data_sources, :deleted_at, :datetime
  end

  def self.down
    drop_table :data_source_versions
    remove_column :data_sources, :version
    remove_column :data_sources, :deleted_at
  end
end
