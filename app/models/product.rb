class Product < ApplicationRecord
  include Administratable


  has_many :orders
  has_many :users, through: :orders


  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # scope :sort_by_reverse_name_asc, -> { order("REVERSE(name) ASC") }
  # scope :sort_by_reverse_name_desc, -> { order("REVERSE(name) DESC") }

  scope :with_orders_count, -> { includes(:orders).group(:name).count(:orders) }

  scope :order_status_percentage, -> {includes(:orders).count}

  # default_scope
  # admin index columns
  def self.index_methods
    %i[name description quantity created_at updated_at caps_name]
    # {method: :name, style_type: :main, sort: :name_alph, class: 'some class' }
  end

  # column :name, data: { dog: 'dogggo' }
  # column :description, class: "tab-grey"
  # column :name, td_partial: 'name_with_description'

  admin_resource do
    list_columns do
      list_column :name, data: { dog: 'dogggo' }
      list_column :description, class: "tab-grey"
      list_column :name, td_partial: 'name_with_description'
      list_column :users
      # list_column :orders_count
    end
    list_filters do
      list_filter :name
      list_filter :description, predicates: %w[cont end start]
    end

    show_lists do
      show_list :orders
      show_list :users
    end
  end

  admin_resource :cups do
    list_columns do
      list_column :description
    end
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

  # def orders_count
  #   orders.size
  # end

  ransacker :reversed_name, formatter: proc { |v| v.reverse } do |parent|
    parent.table[:name]
  end

  ransacker :orders_count, type: :integer do
    sql = "LEFT JOIN orders ON orders.product_id = products.id COUNT orders.id GROUP BY products.id"
    Arel.sql(sql)
  end

  # ransacker :orders_count, type: :integer do
  #   with
  # end
end


# goal: a method that returns an array of ListColumns ??? ListColumnFrames
# Product.all.table_dog do |x|
#   x.list_column :name, class: 'some class'
#   x.list_column :description, class: 'another class', sort: description_alph
# end
# a frame is a :method and options
