class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  enum status: {
    created: 'created',
    confirmed: 'confirmed',
    delivered: 'delivered',
    completed: 'completed'
  }

  def self.filter_methods
    # take array of 2 erlements: symbol and options. And all specific stuff is taken from options
    # [[:user_email, { assoc: :user, predicates: ['cont', 'start', 'end'], method: :email} ], :product_name, :product_quantity]
    %i[user_email product_name product_quantity]
  end
end
