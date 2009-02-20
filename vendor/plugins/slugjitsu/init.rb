require 'slugjitsu'

ActiveRecord::Base.class_eval do
  include Slugjitsu
end