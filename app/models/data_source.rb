class DataSource < ActiveRecord::Base
  SECTIONS = ["Health", "Education", "Environment", "Crime / Policing", "Jobs and the economy", "Parliament", "Consultations and Government Notices", "Travel", "Local information", "Maps", "Geocoding", "Other Sources", "Other countries", "Young People"]
  
  version_fu
  is_paranoid
end
