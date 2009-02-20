module Slugjitsu
  class << self
    attr_accessor :reserved_words
    attr_accessor :max_length
    attr_accessor :downcase
  end
  
  def self.append_features(base)
     base.extend(ClassMethods)
  end

  # creates a dir safe name that is unique to the give scope which is a list of existing names
  def self.dirify(str, scope)
    # Change accented latin characters to their non-accented
    # forms by normalizing the string and then removing 
    # special unicode characters
    str = str.dup
    str = str.parameterize
    
    reserved_words.each do |word|
      scope << word
    end

    str = str.chars[0...max_length] # shorten if over max length
    
    candidate = str
    number = 0 
    
    candidate = "#{str}-#{number = number + 1}" while scope.include?(candidate.to_s)  
    candidate.to_s
  end
  
  # exception thrown if items of a given uri not found
  class URINotFound < ActiveRecord::RecordNotFound
  end
  
  # methods that are added as class methods to ActiveRecord::Base
  module ClassMethods
    def has_slug(field, slug_field=:permalink, options = {})
     options.assert_valid_keys(:scope, :always_update)
     write_inheritable_attribute("slugjitsu_field".to_sym, field)
     write_inheritable_attribute('slugjitsu_always_update'.to_sym, !!options[:always_update])
     scope = write_inheritable_attribute("slugjitsu_scope".to_sym, options[:scope]) if options.has_key? :scope
     slug_field = write_inheritable_attribute("slugjitsu_slug_field".to_sym, slug_field)
     
     class_eval { include Slugjitsu::InstanceMethods }
     
     before_validation_on_create :create_slug
     
     val_opts = if scope
       { :scope => "#{options[:scope].to_s}_id" }
     else
       {}
     end
     
     validates_uniqueness_of slug_field, val_opts
     
    end
  end
  
  module InstanceMethods
    def create_slug
      field = self.send self.class.read_inheritable_attribute(:slugjitsu_field)
      slug_field = self.class.read_inheritable_attribute(:slugjitsu_slug_field)
      always_update = self.class.read_inheritable_attribute(:slugjitsu_always_update)
      slug = send(slug_field)
      send("#{slug_field}=", Slugjitsu::dirify(field, slug_scope)) if field && (always_update || slug.nil? || slug.empty?)
    end
    
    def slug_scope
      scope = self.class.read_inheritable_attribute(:slugjitsu_scope)
      slug = self.class.read_inheritable_attribute(:slugjitsu_slug_field)
      
      if scope
        scope_id = send("#{scope.to_s}_id")
        where = "#{scope.to_s}_id = #{scope_id}"
      else
        where = ''
      end
      
      SlugFinder.new(self, where)
    end
  end
  
  class SlugFinder
    def initialize(record, where)
      @record = record
      @model = @record.class
      @where = where
    end
    
    def include?(slug)
      sql = "select 1 from #{@model.table_name} WHERE "
      sql << "id <> #{@record.id} AND " unless @record.new_record?
      sql << " #{@where} AND " unless @where.empty?
      sql << "#{@model.read_inheritable_attribute(:slugjitsu_slug_field)} = '#{slug}'"
      prohibited.include?(slug) || @model.connection.select_one(sql)
    end
    
    # Used by slugjitsu to add prohibited words to the scope  
    
    def <<(something)
      prohibited << something unless prohibited.include?(something)
    end
    
    def prohibited
      @prohibited ||= []
    end
  end 
end

Slugjitsu.reserved_words   = %w{new}
Slugjitsu.max_length       = 100
Slugjitsu.downcase         = true