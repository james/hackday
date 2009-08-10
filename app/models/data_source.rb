class DataSource < ActiveRecord::Base
  SECTIONS = ["Health", "Education", "Environment", "Crime / Policing", "Jobs and the economy", "Parliament", "Consultations and Government Notices", "Travel", "Local information", "Maps", "Geocoding", "Other Sources", "Other countries", "Young People"]
  
  version_fu
  is_paranoid
  
  validates_presence_of :title, :link
  validates_length_of :title, :maximum=>255
  validates_length_of :category, :maximum=>255
  validates_length_of :link, :maximum=>255
end
