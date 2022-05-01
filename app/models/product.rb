class Product < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders

  # admin index columns
  def self.index_methods
    %i[name description quantity created_at updated_at caps_name]
  end

  def self.filter_methods
    %i[name quantity updated_at]
  end

  def self.show_lists
    %i[orders]
  end

  def caps_name
    name.upcase
  end
end
