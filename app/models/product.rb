class Product < ApplicationRecord
  include Admin::AdminResource


  has_many :orders
  has_many :users, through: :orders


  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # default_scope
  # admin index columns
  def self.index_methods
    %i[name description quantity created_at updated_at caps_name]
    # {method: :name, style_type: :main, sort: :name_alph, class: 'some class' }
  end

  column :name
  column :description


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


# goal: a method that returns an array of ListColumns ??? ListColumnFrames
# Product.all.table_dog do |x|
#   x.list_column :name, class: 'some class'
#   x.list_column :description, class: 'another class', sort: description_alph
# end
# a frame is a :method and options
