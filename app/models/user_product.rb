class UserProduct < ApplicationRecord
  # this is a bug that each model now wants to be administratable. Gotta find out why
  include Administratable
  belongs_to :user
  belongs_to :product
end
