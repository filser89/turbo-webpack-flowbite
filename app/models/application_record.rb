class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # def self.load_admin_resources
  #   Dir[File.join(__dir__,'*.rb')].map { |file| file.match(%r{(?<=/app/models/).*(?=.rb)}).to_s.classify.constantize }
  # end

  # # defines the models that have admin index routes
  # def self.admin_resources
  #   descendants.map(&:admin_resources).flatten
  # end

  # def self.admin_resource(admin_resource_name)
  #   admin_resources.find { |admin_resource| admin_resource.name == admin_resource_name }
  # end

  # the methods that are called to display the instance
  def display_methods
    %i[full_name first_name name last_name title email id]
  end

  # finds the first suitable display method
  def display_method
    display_methods.find { |m| respond_to?(m) } || :id
  end

  # displays object (calls the display method)
  def display_self
    public_send(display_method)
  end

  # default for admin index columns
  def self.index_methods
    new.attributes.keys.map(&:to_sym)
  end

  # default for filters on admin index
  def self.filter_methods
    new.attributes.keys.map(&:to_sym)
  end

  # default for lists on show page
  def self.show_lists
    []
  end

  def show_lists
    self.class.show_lists
  end

  # a way to load all instances by default (will be overwriten in models)
  def self.index_set
    all
  end

  # Convert to strings and symbols

  def self.to_table_s
    model_name.plural
  end

  def self.to_element_s
    model_name.element
  end

  def self.to_foreign_key
    to_element_s.foreign_key
  end

  def self.to_table_sym
    to_table_s.to_sym
  end

  def self.to_element_sym
    to_element_s.to_sym
  end

  # returns a data type that a method returns
  def self.data_type_of(method)
    type_for_attribute(method).type
  end


end
