class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def self.admin_models
    %w[users products orders]
  end

  def self.index_methods
    self.new.attributes.keys.map(&:to_sym)
  end
end
