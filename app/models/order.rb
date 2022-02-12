class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  enum status: {
    created: 'created',
    confirmed: 'confirmed',
    delivered: 'delivered',
    completed: 'completed'
  }
end
