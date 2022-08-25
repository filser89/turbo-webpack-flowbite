class Order < ApplicationRecord
  include Administratable

  STATUSES_ORDER = %w[created confirmed delivered completed].freeze

  belongs_to :user
  belongs_to :product
  enum status: {
    created: 'created',
    confirmed: 'confirmed',
    delivered: 'delivered',
    completed: 'completed'
  }

  scope :by_statuses_order, -> { in_order_of(:status, STATUSES_ORDER) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :index_set, -> { newest_first }

  admin_resource do
    list_columns do
      list_column :product
      list_column :user
      list_column :status
      list_column :created_at
    end
    list_filters do
      list_filter :product
      list_filter :status
      list_filter :created_at
    end
    form_fields do
      form_field :user, :dropdown, collection: User.all
      form_field :product, :dropdown,  collection: Product.all
      # form_field :status, :dropdown, collection:
    end


  end

  def self.filter_methods
    # take array of 2 erlements: symbol and options. And all specific stuff is taken from options
    # [[:user_email, { assoc: :user, predicates: ['cont', 'start', 'end'], method: :email} ], :product_name, :product_quantity]
    %i[user_email product_name product_quantity]
  end
end
