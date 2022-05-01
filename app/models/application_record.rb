class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # defines the models that have admin index routes
  def self.admin_resources
    [User, Product, Order]
  end

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
end
