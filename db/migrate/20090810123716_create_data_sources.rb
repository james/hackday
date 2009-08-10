class CreateDataSources < ActiveRecord::Migration
  def self.up
    create_table :data_sources do |t|
      t.string :title
      t.string :link
      t.text :description
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :data_sources
  end
end
