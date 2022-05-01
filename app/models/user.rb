class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # associatins
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders

  def self.index_methods
    %i[email]
  end

  def self.show_lists
    %i[products orders]
  end
end
