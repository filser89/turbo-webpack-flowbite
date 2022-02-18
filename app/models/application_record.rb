class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def self.admin_models
    %w[users products orders]
  end

  def self.index_methods
    self.new.attributes.keys.map(&:to_sym)
  end

  # a way to load all instances by default (will be overwriten in models)
  def self.index_set
    all
  end
end
