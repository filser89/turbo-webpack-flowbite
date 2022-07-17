class Order < ApplicationRecord
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


  def self.filter_methods
    # take array of 2 erlements: symbol and options. And all specific stuff is taken from options
    # [[:user_email, { assoc: :user, predicates: ['cont', 'start', 'end'], method: :email} ], :product_name, :product_quantity]
    %i[user_email product_name product_quantity]
  end
end
