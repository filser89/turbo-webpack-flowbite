class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # associatins
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders, counter_cache: true

  # kaminari
  paginates_per 5

  def self.index_methods
    %i[email]
  end

  def self.show_lists
    %i[products orders]
  end

  def self.filter_methods
    %i[email]
  end
end
