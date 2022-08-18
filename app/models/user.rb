class User < ApplicationRecord
  include Administratable
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

  # column :email, class: 'some-class another-class'
  # column :products, wrapper_class: 'td-class', class: 'link-class'

  admin_resource do
    list_columns do
      list_column :email
      list_column :encrypted_password
    end
    list_filters do
      list_filter :email
      list_filter :dog
    end
    show_lists do
      show_list :products
    end
  end

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
