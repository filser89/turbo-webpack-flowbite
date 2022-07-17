class Product < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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

  ransacker :reversed_name, type: :string, formatter: proc { |v| v.reverse } do |parent|
    parent.table[:name]
  end
end
