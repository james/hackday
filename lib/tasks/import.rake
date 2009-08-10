desc "import csv data from guardian"
task :import => :environment do
  require 'fastercsv'
  FasterCSV.foreach(RAILS_ROOT+"/lib/tasks/apis.csv", :headers => :first_row) do |row|
    c = DataSource.new
    row.each_with_index do |cell, index|
      p "#{cell[0]}: #{cell[1]}"
      c.update_attribute cell[0], cell[1]
    end
    c.save!
  end
end