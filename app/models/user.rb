class User < ApplicationRecord
  include Admin::AdminResource
  # extend Admin::AdminResource
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # associatins
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders, counter_cache: true

  # kaminari
  paginates_per 5

  column :email, class: 'some-class another-class'
  column :products, wrapper_class: 'td-class', class: 'link-class'

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
